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

# import functions_framework
# import requests
# import os
# from flask import jsonify

# @functions_framework.http
# def get_geocode(request):
#     """HTTP Cloud Function to call Google Geocoding API securely."""
#     try:
#         request_json = request.get_json(silent=True)

#         if not request_json or 'address' not in request_json:
#             return jsonify({"error": "Missing 'address' in request"}), 400

#         address = request_json['address']
#         api_key = os.environ.get("MAPS_API_KEY")

#         if not api_key:
#             return jsonify({"error": "API key not set"}), 500

#         response = requests.get(
#             "https://maps.googleapis.com/maps/api/geocode/json",
#             params={"address": address, "key": api_key}
#         )

#         if response.status_code != 200:
#             return jsonify({"error": "Failed to fetch geocode data"}), 500

#         return jsonify(response.json()), 200

#     except Exception as e:
#         return jsonify({"error": str(e)}), 500

import os
import requests
import functions_framework
from flask import jsonify, request
from urllib.parse import urlencode

# Uncomment below to support Firebase Auth token verification
import firebase_admin
from firebase_admin import auth, credentials

if not firebase_admin._apps:
    firebase_admin.initialize_app()

def verify_firebase_token(request):
    auth_header = request.headers.get('Authorization')
    if not auth_header or not auth_header.startswith("Bearer "):
        raise Exception("Missing or invalid Authorization header")
    id_token = auth_header.split("Bearer ")[1]
    return auth.verify_id_token(id_token)


@functions_framework.http
def get_map_data(request):
    """HTTP Cloud Function to securely provide geocode or static map data."""

    try:
        # Optional Firebase token verification
        # user = verify_firebase_token(request)

        request_json = request.get_json(silent=True)
        if not request_json:
            return jsonify({"error": "Missing JSON body"}), 400

        api_key = os.environ.get("MAPS_API_KEY")

        print("API key: " + api_key)
        if not api_key:
            return jsonify({"error": "API key not set"}), 500

        # Geocoding API (get lat/lng from address)
        if 'address' in request_json:
            address = request_json['address'].strip()
            if not address:
                return jsonify({"error": "Address cannot be empty"}), 400

            geocode_url = "https://maps.googleapis.com/maps/api/geocode/json"
            response = requests.get(geocode_url, params={"address": address, "key": api_key})

            if response.status_code != 200:
                return jsonify({"error": "Geocoding API failed"}), 502

            return jsonify(response.json()), 200

        # Static Map URL (get image link from lat/lng)
        elif 'lat' in request_json and 'lng' in request_json:
            try:
                lat = float(request_json['lat'])
                lng = float(request_json['lng'])
            except (TypeError, ValueError):
                return jsonify({"error": "Invalid latitude or longitude format"}), 400

            zoom = int(request_json.get('zoom', 15))
            map_params = {
                "center": f"{lat},{lng}",
                "zoom": str(zoom),
                "size": "600x600",
                "maptype": "hybrid",
                "markers": f"color:red|{lat},{lng}",
                "key": api_key,
            }

            static_map_url = "https://maps.googleapis.com/maps/api/staticmap"
            return jsonify({
                "url": f"{static_map_url}?{urlencode(map_params)}",
                "lat": lat,
                "lng": lng
            }), 200

        else:
            return jsonify({"error": "Invalid request: provide 'address' or 'lat' and 'lng'"}), 400

    except Exception as e:
        return jsonify({"error": f"Server error: {str(e)}"}), 500