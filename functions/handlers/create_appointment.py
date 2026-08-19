from firebase_functions import https_fn
from firebase_setup import db  # Ensures firebase_admin.initialize_app() runs at startup

@https_fn.on_call()
def create_appointment(req: https_fn.CallableRequest):
    # 1. Verify authentication state explicitly
    if req.auth is None:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.UNAUTHENTICATED,
            message="You must be logged in to create an appointment.",
        )

    # 2. Extract and validate parameters
    date = req.data.get("date")
    if not date:
        raise https_fn.HttpsError(
            code=https_fn.FunctionsErrorCode.INVALID_ARGUMENT,
            message="Date is required.",
        )

    print(f"Appointment date: {date} for user {req.auth.uid}")

    return {
        "success": True,
        "date": date,
        "user_id": req.auth.uid,
    }