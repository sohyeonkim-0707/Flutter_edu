import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterBasicMessageChannel(
        name: "myMessageChannel",
        binaryMessenger: controller.bindaryMessenger,
        codec: FlutterStringCodec.sharedInstance()
    )
    channel.setMessageHandler {
        (message:Any?, reply: FlutterReply) -> Void in
        reply("Hi from iOS")
        channel.sendMessage("Hello i am ios native"){
            (reply: Any?) -> Void in
            print("%@", reply as! String)
        }
    }

    //method channel..................
    let methodChannel = FlutterMethodChannel(
        name: "myMethodChannel",
        binaryMessenger: controller.binaryMessenger
    )
    methodChannel.setMethodHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        switch(call.method){
            case "parameterMap":
                let argument = call.arguments as? Dictionary<String, Any>
                let resultArg = ["one":"hello", "two":"world"]
                result(resultArg)
            default:
                break;
        }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
