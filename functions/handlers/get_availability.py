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
    # 1. Verify authentication
    if user is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="You must be logged in to view availability.",
        )

    # 2. Extract parameters
    studio_id = req.data.get("studioId")
    year = req.data.get("year")
    month = req.data.get("month")

    # 3. Validate parameters
    if not studio_id:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="studioId is required.",
        )

    if not isinstance(year, int):
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="year must be an integer.",
        )

    if not isinstance(month, int) or not 1 <= month <= 12:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="month must be between 1 and 12.",
        )

    # 4. Get current UTC date
    now_utc = datetime.now(timezone.utc)
    today_utc = now_utc.date()

    # 5. Determine requested month's boundaries
    first_day = date(year, month, 1)

    if month == 12:
        next_month = date(year + 1, 1, 1)
    else:
        next_month = date(year, month + 1, 1)

    # 6. Requested month is completely in the past
    if next_month <= today_utc:
        return {
            "studioId": studio_id,
            "year": year,
            "month": month,
            "availability": [],
        }

    # 7. Start from today for current month,
    #    otherwise start from the first day.
    start_date = max(first_day, today_utc)

    # 8. Firestore reference
    db = firestore.client()

    availability_ref = (
        db.collection("studios")
        .document(studio_id)
        .collection("availability")
    )

    availability = []

    # 9. Retrieve availability
    current_date = start_date

    while current_date < next_month:

        document_id = current_date.strftime("%Y-%m-%d")

        doc = availability_ref.document(document_id).get()

        if doc.exists:
            availability.append({
                "date": document_id,
                **doc.to_dict(),
            })

        current_date = date.fromordinal(
            current_date.toordinal() + 1
        )

    # 10. Return
    return {
        "studioId": studio_id,
        "year": year,
        "month": month,
        "availability": availability,
    }