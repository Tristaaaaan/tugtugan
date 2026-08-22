from firebase_functions import https_fn
from firebase_admin import firestore

from datetime import datetime, date

from firebase_functions import https_fn


from datetime import datetime, date, timezone

from firebase_admin import firestore
from firebase_functions import https_fn


@https_fn.on_call()
def get_availability(req: https_fn.CallableRequest):
    user = req.auth
    
    print(f"--- [get_availability] Function Invoked ---")
    print(f"Auth Context: {'Authenticated as ' + user.uid if user else 'UNAUTHENTICATED'}")
    print(f"Request Data: {req.data}")

    # 1. Verify authentication
    if user is None:
        print("[-] Auth Error: User is not logged in.")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="You must be logged in to view availability.",
        )

    # 2. Extract parameters
    studio_id = req.data.get("studioId")
    year = req.data.get("year")
    month = req.data.get("month")

    print(f"[+] Params extracted -> studioId: {studio_id}, year: {year}, month: {month}")

    # 3. Validate parameters
    if not studio_id or not isinstance(year, int) or not isinstance(month, int) or not (1 <= month <= 12):
        print("[-] Validation Error: Missing or invalid parameters.")
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="Invalid parameters provided.",
        )

    # 4. Get current UTC bounds
    now_utc = datetime.now(timezone.utc)
    
    # Start of today (00:00:00 UTC)
    today_start_utc = datetime(now_utc.year, now_utc.month, now_utc.day, tzinfo=timezone.utc)
    today_start_ms = int(today_start_utc.timestamp() * 1000)

    # End of the CURRENT month (1st of next month in real-time UTC)
    if now_utc.month == 12:
        current_month_end_utc = datetime(now_utc.year + 1, 1, 1, tzinfo=timezone.utc)
    else:
        current_month_end_utc = datetime(now_utc.year, now_utc.month + 1, 1, tzinfo=timezone.utc)
    
    current_month_end_ms = int(current_month_end_utc.timestamp() * 1000)

    # 5. Determine requested month's boundaries
    requested_start_utc = datetime(year, month, 1, tzinfo=timezone.utc)
    
    if month == 12:
        requested_end_utc = datetime(year + 1, 1, 1, tzinfo=timezone.utc)
    else:
        requested_end_utc = datetime(year, month + 1, 1, tzinfo=timezone.utc)

    requested_start_ms = int(requested_start_utc.timestamp() * 1000)
    requested_end_ms = int(requested_end_utc.timestamp() * 1000)

    # 6. Restrict range to: [MAX(requested_start, today), MIN(requested_end, current_month_end)]
    effective_start_ms = max(requested_start_ms, today_start_ms)
    effective_end_ms = min(requested_end_ms, current_month_end_ms)

    # 7. Check if the effective range is invalid (i.e. requested month is completely in the past OR in a future month)
    if effective_start_ms >= effective_end_ms:
        print(f"[!] Requested target range ({year}-{month}) falls outside valid range [Today ({today_start_utc.date()}) - End of Month ({current_month_end_utc.date()})]. Returning empty.")
        return {
            "studioId": studio_id,
            "year": year,
            "month": month,
            "availability": [],
        }

    print(f"[+] Querying Firestore timestamp range: {effective_start_ms} to {effective_end_ms}")

    # 8. Query Firestore collection by timestamp range
    db = firestore.client()
    availability_ref = (
        db.collection("studios")
        .document(studio_id)
        .collection("availability")
    )

    docs = (
        availability_ref
        .where("date", ">=", effective_start_ms)
        .where("date", "<", effective_end_ms)
        .stream()
    )

    availability = []
    for doc in docs:
        doc_data = doc.to_dict()
        doc_data["id"] = doc.id
        print(f"  [✓] Found Record ID '{doc.id}' | Date ms: {doc_data.get('date')} | Data: {doc_data}")
        availability.append(doc_data)

    print(f"[+] Total records found for {year}-{month}: {len(availability)}")

    return {
        "studioId": studio_id,
        "year": year,
        "month": month,
        "availability": availability,
    }