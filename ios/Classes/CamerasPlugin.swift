import Flutter
import UIKit
import AVFoundation


public class CamerasPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cameras", binaryMessenger: registrar.messenger())
    let instance = CamerasPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "getPlatformType":
        result("ios")
    case "getAvailableCameras":
        result(getAvailableCameras())
    default:
        result(FlutterMethodNotImplemented)
    }
  }

  private func getAvailableCameras() -> [[String: Any]] {
    var cameras = [[String: Any]]()
    
    let devices = AVCaptureDevice.devices(for: .video)
    for device in devices {
        let lensDirection: String
        switch device.position {
        case .back:
            lensDirection = "back"
        case .front:
            lensDirection = "front"
        default:
            lensDirection = "external"
        }
        
        let camera: [String: Any] = [
            "id": device.localizedName,
            "label": device.localizedName,
            "lensDirection": lensDirection
        ]
        cameras.append(camera)
    }
    
    return cameras
  }


}
  