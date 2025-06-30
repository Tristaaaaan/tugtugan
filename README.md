# Tugtugan

## In Progress

Tugtugan will be the go-to platform for musicians looking for practice studios or jam sessions with other artists. It provides a space for small to medium-sized studios to easily manage client appointments. 

* Find music studios near you.
* Book appointments effortlessly.
* Rent music equipments

## Core Technologies

### App Development
- **Flutter** (`v3.32.x+`) 
- **Dart** (`v3.8.x+`) 
- **Riverpod** (`v2.x+`) 
- **GoRouter** 

### Backend Services
- **Firebase**:
  - Authentication
  - Firestore 
  - Firebase Storage 
  - Cloud Functions 

### APIs & Integrations
- **Google Maps Platform**:
  - Maps SDK for Flutter (`google_maps_flutter`)
  - Places API (location search)

### Get Started
# 🚀 Get Started

## 🔥 Firebase iOS Setup for Multiple Flavors in Flutter

This guide explains how to configure your Flutter iOS app to automatically use the correct `GoogleService-Info.plist` for multiple environments (flavors) such as `dev` and `prod`.

---

## 📁 Folder Structure

```
project-root/
├── ios/
│   ├── Runner/
│   ├── config/
│   │   ├── dev/
│   │   │   └── GoogleService-Info.plist
│   │   └── prod/
│   │       └── GoogleService-Info.plist
```

✅ Place the downloaded `GoogleService-Info.plist` files from your Firebase Console inside the appropriate `config/dev/` or `config/prod/` folders.

---

## 🍎 iOS Configuration (Xcode)

### 1. Open your iOS project in Xcode

```bash
open ios/Runner.xcworkspace
```

---

### 2. Add a New Run Script in Build Phases

1. Click on the **Runner** project.
2. Select the **Runner** target.
3. Go to the **Build Phases** tab.
4. Click the ➕ icon and select **"New Run Script Phase"**.
5. Drag the new script **above** `Compile Sources`.
6. Paste the following shell script:

```bash
environment="default"

# Extract the scheme name from CONFIGURATION (e.g., Debug-dev or Release-prod)
if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then
  environment=${BASH_REMATCH[1]}
fi

echo "Current environment: $environment"

# File to copy
GOOGLESERVICE_INFO_PLIST="GoogleService-Info.plist"
GOOGLESERVICE_INFO_FILE="${PROJECT_DIR}/config/${environment}/${GOOGLESERVICE_INFO_PLIST}"

# Check if the file exists
echo "Looking for ${GOOGLESERVICE_INFO_PLIST} at: ${GOOGLESERVICE_INFO_FILE}"
if [ ! -f "$GOOGLESERVICE_INFO_FILE" ]; then
  echo "❌ No GoogleService-Info.plist found for environment '$environment'"
  exit 1
fi

# Destination path
PLIST_DESTINATION="${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app"
echo "✅ Copying to: ${PLIST_DESTINATION}"

# Perform the copy
cp "$GOOGLESERVICE_INFO_FILE" "$PLIST_DESTINATION"
```

---

### 3. Rename Your Build Configurations (Optional but Recommended)

Use the following naming convention for build configurations to make the script work:

- `Debug-dev`
- `Release-dev`
- `Debug-prod`
- `Release-prod`

You can configure this in:

```
Project > Info > Configurations
```

---

## 🧪 Testing with Flavors

Run a specific flavor from the command line:

```bash
flutter run --flavor dev -t lib/main_dev.dart
flutter run --flavor prod -t lib/main_prod.dart
```

Or use **Xcode > Product > Scheme** to select and run the flavor manually.

---

## 🛑 .gitignore Setup

To avoid committing sensitive Firebase configuration files, add this to your `.gitignore`:

```gitignore
# Ignore Firebase plist files per environment
ios/config/**/GoogleService-Info.plist
```

---

## 📺 Video Reference

Inspired by this video:  
[🔥 Firebase with Flutter Flavors on iOS (YouTube)](https://www.youtube.com/watch?v=Vhm1Cv2uPko&t=410s)


## Contact

Interested in contributing to the project? Feel free to reach out!

* Email: markristanfabellar.pro@gmail.com
* GitHub: [Tristaaaaan](https://github.com/Tristaaaaan)

