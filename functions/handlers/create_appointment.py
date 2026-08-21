from firebase_functions import https_fn

from datetime import datetime, timezone

from firebase_admin import firestore
from firebase_functions import https_fn


@https_fn.on_call()
def create_appointment(req: https_fn.CallableRequest):
    user = req.auth
    # 1. Verify authentication
    if user is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="You must be logged in to create an appointment.",
        )

    # 2. Get authenticated customer
    customer_id = req.auth.uid

    # 3. Get request data
    studio_id = req.data.get("studioId")
    slots = req.data.get("slots")

    # 4. Validate studio ID
    if not studio_id:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="studioId is required.",
        )

    # 5. Validate slots is a list
    if not isinstance(slots, list) or len(slots) == 0:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="At least one slot is required.",
        )

    # 6. Validate and normalize each slot
    validated_slots = []
    
    for i, slot in enumerate(slots):
        if not isinstance(slot, dict):
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
                message=f"Slot at index {i} has invalid format. Expected a map.",
            )

        # Extract startAt and endAt
        start_at_raw = slot.get("startAt")
        end_at_raw = slot.get("endAt")

        if start_at_raw is None or end_at_raw is None:
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
                message=f"Slot at index {i} must contain 'startAt' and 'endAt'.",
            )

        # Unwrap protobuf Int64Value structure
        # Firebase sends: { "@type": "type.googleapis.com/google.protobuf.Int64Value", "value": "1787274000000" }
        if isinstance(start_at_raw, dict):
            start_at = start_at_raw.get("value")
        else:
            start_at = start_at_raw

        if isinstance(end_at_raw, dict):
            end_at = end_at_raw.get("value")
        else:
            end_at = end_at_raw

        # Convert string timestamps to integers
        try:
            start_at = int(start_at)
            end_at = int(end_at)
        except (ValueError, TypeError):
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
                message=f"Slot at index {i}: 'startAt' and 'endAt' must be valid timestamps.",
            )

        # Validate time order
        if start_at >= end_at:
            raise https_fn.HttpsError(
                code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
                message=f"Slot at index {i}: 'startAt' must be before 'endAt'.",
            )

        # Add normalized slot to validated list
        validated_slots.append({
            "startAt": start_at,
            "endAt": end_at,
        })

    # 7. Firestore
    db = firestore.client()

    # 8. Generate appointment document
    appointment_ref = db.collection("appointments").document()

    # 9. Generate booking number
    booking_number = f"TUGTUGAN-{appointment_ref.id[:8].upper()}"

    # 10. Current UTC timestamp
    now = int(datetime.now(timezone.utc).timestamp() * 1000)

    # 11. Create appointment
    appointment_data = {
        "approvedAt": None,
        "bookingNumber": booking_number,
        "createdAt": now,
        "customerId": customer_id,
        "slots": validated_slots,  # Use normalized slots
        "status": "pending",
        "studioId": studio_id,
        "updatedAt": now,
    }

    appointment_ref.set(appointment_data)

    # 12. Return
    return {
        "success": True,
        "appointmentId": appointment_ref.id,
        "bookingNumber": booking_number,
    }