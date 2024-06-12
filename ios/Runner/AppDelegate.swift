import UIKit
import Flutter
import flutter_downloader
import FirebaseCore
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, FlutterStreamHandler {
  
  private var eventSink: FlutterEventSink?
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)
   
    UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { [self] granted, _ in
      guard granted else { return }
      DispatchQueue.main.async {
        application.registerForRemoteNotifications()
      }
    }
    
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)

    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { registry in
      // Register any additional plugins for Flutter Local Notifications if needed
    }

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
              
      if let registrar = self.registrar(forPlugin: "e_class.course.com/muteMic") {
          MyChannel.register(with: registrar)
      }
      //MyChannel.register(with: controller)
    let detectScreenRecordingChannel = FlutterEventChannel(name: "detectScreenRecordingChannel", binaryMessenger: controller.binaryMessenger)
    detectScreenRecordingChannel.setStreamHandler(self)

      NotificationCenter.default.addObserver(self, selector: #selector(preventScreenRecording), name: UIScreen.capturedDidChangeNotification, object: nil)


    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    self.eventSink = events
      print("screeeeeeeeen recording1")
    detectScreenRecording { [self] in
      guard let eventSink = eventSink else {
        return
      }
      if UIScreen.main.isCaptured {
        print("Screen recording is active.")
        eventSink(true)
      } else {
        print("Screen recording is not active.")
        eventSink(false)
      }
    }
    return nil
  }

  func onCancel(withArguments arguments: Any?) -> FlutterError? {
    eventSink = nil
      print("screeeeeeeeen recording closed")
    return nil
  }
    
    @objc func preventScreenRecording() {
        if #available(iOS 11.0, *) {
            let isCaptured = UIScreen.main.isCaptured
            
            guard let eventSink = eventSink else {
              return
            }
            if isCaptured {
              print("Screen recording is active.")
              eventSink(true)
            } else {
              print("Screen recording is not active.")
              eventSink(false)
            }

        }
    }
    
    func detectScreenRecording(action: @escaping () -> ()) {
      let mainQueue = OperationQueue.main
      NotificationCenter.default.addObserver(forName: UIScreen.capturedDidChangeNotification, object: nil, queue: mainQueue) { notification in
        // Executes when screen recording status changes
        //action()
          guard let eventSink = self.eventSink else {
            return
          }
          print("screeeeeeeeen recording")
         // eventSink(true)
      }
    }
}

private func registerPlugins(registry: FlutterPluginRegistry) {
  if !registry.hasPlugin("FlutterDownloaderPlugin") {
    FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
  }
}
  

// Prevent screenshots
extension UIApplication {
  private static let privateSelector = Selector(("setDisableScreenshot:"))

  @objc var disableScreenshot: Bool {
    get { return false }
    set { }
  }

  class func swizzleScreenshotPrevention() {
    guard
      let originalMethod = class_getInstanceMethod(UIApplication.self, #selector(getter: disableScreenshot)),
      let swizzledMethod = class_getInstanceMethod(UIApplication.self, privateSelector)
    else { return }

    method_exchangeImplementations(originalMethod, swizzledMethod)
  }

  // Called when the app is launched
  override open var next: UIResponder? {
    UIApplication.swizzleScreenshotPrevention()
    return super.next
  }
}

