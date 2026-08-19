
from firebase_admin import credentials, firestore, initialize_app

# --- Load both credentials ---
cred_dev = credentials.Certificate("ServiceAccountDev.json")
# cred_prod = credentials.Certificate("")

# --- Choose environment dynamically ---
# ENV = "dev"  # or "dev"

# if ENV == "prod":
#     app = initialize_app(cred_prod)
# else:
app = initialize_app(cred_dev)

db = firestore.client(app)