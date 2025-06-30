import Flutter
import UIKit
import FirebaseCore
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()

    if let path = Bundle.main.path(forResource: "Info", ofType: "plist"),
       let infoDict = NSDictionary(contentsOfFile: path),
       let apiKey = infoDict["GMSApiKey"] as? String {
      GMSServices.provideAPIKey(apiKey)
    } else {
      print("❌ Failed to load Google Maps API key from Info.plist")
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
