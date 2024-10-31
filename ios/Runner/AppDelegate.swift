import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        FlutterMethodChannel(
            name: "ffi_the_right_way",
            binaryMessenger: (window?.rootViewController as! FlutterViewController).binaryMessenger
        ).setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            switch call.method {
            case "add":
                let args = call.arguments as! Dictionary<String, Any>
                let firstInput = args["input1"] as! Double
                let secondInput = args["input2"] as! Double
                result(self.addNumbers(firstInput, secondInput))
                
            default:
                result(FlutterMethodNotImplemented)
            }
            
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func addNumbers(_ firstInput: Double, _ secondInput: Double) -> Double {
        return firstInput + secondInput
    }
}
