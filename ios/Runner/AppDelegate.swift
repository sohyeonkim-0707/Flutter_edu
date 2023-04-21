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
    name: 'myMessageChannel',
    binaryMessenger: controller.binaryMessenger,
    codec: FlutterStringCodec.sharedInstance()
  )

  channel.setMessageHandler{
    (messsage: Any?, reply:FlutterReply) -> Void in
    reply('hi from ios')
    channel.sendMessage('hello i am ios native'){
    (reply)
    }
  }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
