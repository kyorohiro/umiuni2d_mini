import Flutter
import UIKit


public class SwiftUmiuni2dPlatformPathPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "umiuni2d_platform_path", binaryMessenger: registrar.messenger())
    let instance = SwiftUmiuni2dPlatformPathPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    

    if(call.method == "getApplicationDirectory") {
        let r:String = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0];
        result(r);
    } else if(call.method == "getCacheDirectory") {
        let r:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0];
        result(r);
    } else if(call.method == "getDocumentDirectory") {
        let r:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];
        result(r);
    } else {
        result(FlutterMethodNotImplemented);
    }
    let document:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0];// as! String
    let cache:String = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true)[0];
    let tsmp:String = NSTemporaryDirectory();

    //var tmp:String = NSTemporaryDirectory();
    result(document+cache+tsmp);
    result(FlutterMethodNotImplemented);
  }
}
extension FileManager {
    class func documentsDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    class func cachesDir() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}
