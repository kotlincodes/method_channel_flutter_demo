import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: "com.example.native_integration_demo/native",
                                              binaryMessenger: controller.binaryMessenger)
    nativeChannel.setMethodCallHandler(
      { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if call.method == "getNativeMessage" {
          result(self.getNativeMessage())
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    )

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func getNativeMessage() -> String {
    return "Hello from iOS!"
  }
}
