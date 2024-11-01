import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FfiTRWHostApi {
    var timer: Timer? = nil
    var flutterApi: FfiTRWFlutterApi? = nil
    var result: Int64 = 0
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        let binaryMessenger = (window?.rootViewController as! FlutterViewController).binaryMessenger
        
        FfiTRWHostApiSetup.setUp(binaryMessenger: binaryMessenger, api: self)
        flutterApi = FfiTRWFlutterApi(binaryMessenger: binaryMessenger)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func add(a: Double, b: Double) throws -> Double {
        return a + b
    }
    
    func startTimer() throws {
        timer?.invalidate();
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.flutterApi?.onReceiveTimerResult(result: self.result, completion: {result in
                switch(result) {
                case .success():
                    self.result += 1
                case .failure(let errorResult):
                    print("an error occurred: \(errorResult)")
                }
            })
        })
    }
    
    func stopTimer() throws {
        timer?.invalidate()
        timer = nil
        result = 0
    }
}
