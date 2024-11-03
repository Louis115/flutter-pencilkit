import Flutter
import UIKit

public class SwiftPencilKitPlugin: NSObject, FlutterPlugin {
  private static var channel: FlutterMethodChannel?

  public static func register(with registrar: FlutterPluginRegistrar) {
    registrar.register(
      FLPencilKitFactory(messenger: registrar.messenger()),
      withId: "plugins.mjstudio/flutter_pencil_kit"
    )

    channel = FlutterMethodChannel(
      name: "plugins.mjstudio/flutter_pencil_kit/util",
      binaryMessenger: registrar.messenger()
    )

    channel?.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      PencilKitUtil.handleMethodCall(call: call, result: result)
    }
  }

  public static func deregister() {
    // Remove method call handler to ensure complete cleanup
    channel?.setMethodCallHandler(nil)
    channel = nil
  }
}

private enum PencilKitUtil {
  static func handleMethodCall(call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "checkAvailable" {
      if #available(iOS 13.0, *) {
        result(true)
      } else {
        result(false)
      }
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
