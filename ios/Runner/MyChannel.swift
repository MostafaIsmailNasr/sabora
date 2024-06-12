import Flutter

class MyChannel: UIViewController, FlutterPlugin, UIDocumentInteractionControllerDelegate  {
    let fileManager = FileManager.default

    var documentInteractionController: UIDocumentInteractionController?
       
       override func viewDidLoad() {
           super.viewDidLoad()
       }
       
    // UIDocumentInteractionControllerDelegate method
       func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
           return self
       }
    
    @objc(registerWithRegistrar:)
    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "e_class.course.com/muteMic", binaryMessenger: registrar.messenger())
        let instance = MyChannel()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "viewFile" {
            if let filePath = call.arguments as? String {
                openFile(filePath)
                result(nil) // Return null as the result or modify as needed
            } else {
                result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid file path", details: nil))
            }
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    func openFile(_ filePath: String) {
        let fileURL = URL(fileURLWithPath: filePath)
               documentInteractionController = UIDocumentInteractionController(url: fileURL)
               documentInteractionController?.delegate = self
               documentInteractionController?.presentOpenInMenu(from: view.frame, in: view, animated: true)
           }
//        if fileManager.fileExists(atPath: filePath) {
//            if let fileContents = fileManager.contents(atPath: filePath) {
//                if let fileString = String(data: fileContents, encoding: .utf8) {
//                    print(fileString)
//                }
//            }
//        } else {
//            print("File does not exist"+filePath)
//        }
    //}
}
