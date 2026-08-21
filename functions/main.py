import firebase_admin
from firebase_admin import credentials, firestore

# Then import handlers AFTER initialization
from handlers.create_appointment import create_appointment
from handlers.get_availability import get_availability

# Initialize ONCE at module level
cred_dev = credentials.Certificate("ServiceAccountDev.json")
app = firebase_admin.initialize_app(cred_dev)
db = firestore.client(app)


__all__ = [
    "create_appointment",
    "get_availability",
]