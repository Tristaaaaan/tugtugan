# from firebase_functions import scheduler_fn
# import firebase_admin
# from firebase_admin import credentials, firestore
# import random
# import string
# import os

# # Optional: use absolute path if running from different dirs
# # cred_path = os.path.abspath("./ServiceAccountKeyDev.json")
# cred_path = "./ServiceAccountKeyDev.json"
# cred = credentials.Certificate(cred_path)

# # Initialize Firebase Admin SDK with the service account key
# app = firebase_admin.initialize_app(cred)
# db = firestore.client()

# # Function to generate a random name
# def generate_random_name(length=6):
#     return ''.join(random.choices(string.ascii_letters, k=length))

# # Scheduled Cloud Function that runs every 1 minute
# @scheduler_fn.on_schedule(schedule="* * * * *", timezone="UTC")
# def update_studio_names(event: scheduler_fn.ScheduledEvent) -> None:
#     studios_ref = db.collection("studios")
#     docs = studios_ref.stream()

#     for doc in docs:
#         new_name = generate_random_name()
#         studios_ref.document(doc.id).update({"name": new_name})
#         print(f"Updated document {doc.id} with new name: {new_name}")