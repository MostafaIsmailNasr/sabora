import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:Sabora/presentation/controllers/course_details/course_details_binding.dart';
import 'package:Sabora/presentation/controllers/home/home_binding.dart';
import 'package:Sabora/presentation/controllers/teachers/teachers_binding.dart';
import 'package:Sabora/presentation/pages/course_details/course_details.dart';
import 'package:Sabora/presentation/pages/home/parent_main_screen.dart';
import 'package:Sabora/presentation/pages/main/teachers/teacher_details/teacher_details.dart';
import 'package:http/http.dart' as http;
import 'app/notifications/notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

//import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:Sabora/app/services/local_storage.dart';
import 'package:Sabora/app/util/dependency.dart';
import 'package:Sabora/presentation/app.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

//import 'package:screenshot_callback/screenshot_callback.dart';
import 'package:flutter_secure_screen/flutter_secure_screen.dart';

import 'data/providers/network/api_endpoint.dart';

NotificationService notificationService = NotificationService();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: "
      "${message.notification?.title.toString()}/${message.notification?.body.toString()}/${message.data["click_action"].toString()}");

}

// void listenToNotificationStream() =>
//     notificationService.behaviorSubject.listen((payload) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => MySecondScreen(payload: payload)));
//     });

BuildContext? overLayContext;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize(
      debug: true,
      // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  await DependencyCreator.init();
  await initServices();
  //await ScreenUtil.ensureScreenSize();
  // NotificationService notificationService=NotificationService();

  notificationService.init();
  // listenToNotificationStream();
  notificationService.initializePlatformNotifications();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(AncestorWidget(data: 'Ancestor Data', child: RestartWidget(child: App())));
  });
  //configLoading();
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({super.key, required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()!.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget>
    with WidgetsBindingObserver {
  Key key = UniqueKey();
  bool isScreenRecording = false;

  BuildContext? appContext;
  //var locale;
  static const platform = MethodChannel('e_class.course.com/muteMic');

// EventChannel
  final eventChannel = const EventChannel('detectScreenRecordingChannel');

  StreamSubscription<void>? _screenRecordListen;

  /// 截屏动作 暂只支持iOS
  StreamSubscription<void>? _screenShotsListen;
  bool _isInForeground = true;
  bool _isBlureAdded = false;

  Future<void> _setMicMute() async {
    try {
      await platform.invokeMethod('setMicMute');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  Future<void> _releaseMicMute() async {
    try {
      await platform.invokeMethod('releaseMicMute');
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("state_eclass");
    print(state);
    _isInForeground = state == AppLifecycleState.resumed;
    if (Platform.isAndroid) {
      if (_isInForeground) {
        _setMicMute();
      } else {
        _releaseMicMute();
      }
    }
  }

  @override
  void dispose() {
    print("state_eclass_dispose");
    WidgetsBinding.instance.removeObserver(this);
    _releaseMicMute();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setMicMute();
    // _screenRecordListen =
    //     FlutterSecureScreen.singleton.onScreenRecord?.listen(_onScreenRecord);
    _screenShotsListen =
        FlutterSecureScreen.singleton.onScreenShots?.listen(_onScreenShots);
    print("state_eclass_init");
    // Start listening for events
    final streamSubscription =
        eventChannel.receiveBroadcastStream().listen((event) {
      // Handle the received event
      print("screeeeeeeeen recording3$event");
      print("screeeeeeeeen aliiiii$event");

      if ((event as bool) == true) {
        if (!_isBlureAdded) {
          print("heeeer1");
          BuildContext currentContext = navigatorKey.currentState!.context;

          Navigator.of(currentContext).push(TutorialOverlay());
        }
        _isBlureAdded = true;
      } else {
        if (overLayContext != null) {
          Navigator.pop(overLayContext!);
        }
        _isBlureAdded = false;
        print("heeeer2");
      }
    });

// Stop listening when no longer needed

    // final store = Get.find<LocalStorageService>();
    // locale = store.lang == "ar" ? Locale('ar', '') : Locale('en', '');
    // Get.updateLocale(locale);
    init();
  }

  void _onScreenRecord(dynamic event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Screen Recording Blocked'),
          content: const Text('Screen recording is not allowed in this app.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onScreenShots(dynamic event) async {
    final storage = Get.find<LocalStorageService>();

    var uri = Uri.parse(APIEndpoint.apiURL + "/development/screenshots");

    // create multipart request
    var request = http.MultipartRequest("POST", uri);

    // multipart that takes file
    // var multipartFile = new http.MultipartFile('file', stream, length,
    //     filename: basename(imageFile.path));

    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      'x-api-key': '1234321',
      "X-Locale": storage.lang ?? "ar",
      'Authorization':
          storage.apiToken == null ? "" : ("Bearer " + storage.apiToken!)
    });

    // send
    var response = await request.send();
    print("development/screenshots");
    print(response);
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Screen Shot Blocked'),
    //       content: Text('Screen Shot is not allowed in this app.'),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }

  //late ScreenshotCallback screenshotCallback;

  String text = "Ready..";

  Future<void> detectScreenRecording() async {
    try {
      isScreenRecording =
          await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } catch (e) {
      print('Error detecting screen recording: $e');
    }
  }

  void init() async {
    // Call the 'detectScreenRecording' method to check if screen recording is happening

    // if( Platform.isIOS) {
    //   checkAndDisableScreenRecording();
    // }else{
    detectScreenRecording();
    //  }
    mutMichrophone();
    //  final result = await FlutterScreenRecording.stopRecordScreen;
    // await initScreenshotCallback();
  }

  void mutMichrophone() async {
    // final session = await AudioSession.instance;
    // await session.configure(const AudioSessionConfiguration.music(),);
    // await session.setActive(true);
    //await session.setForceSpeakerEnabled(true);
    //await session.setOutputAudioSource(OutputAudioSource.notification);
  }

  //It must be created after permission is granted.
  Future<void> initScreenshotCallback() async {
    // screenshotCallback = ScreenshotCallback();
    //
    // screenshotCallback.addListener(() {
    //   setState(() {
    //     text = "Screenshot callback Fired!";
    //   });
    // });
    //
    // screenshotCallback.addListener(() {
    //   print("We can add multiple listeners ");
    // });
  }

  // @override
  // void dispose() {
  //   screenshotCallback.dispose();
  //   super.dispose();
  // }
  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    appContext = context;
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
//
// void configLoading() {
//   EasyLoading.instance
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.fadingCircle
//     ..loadingStyle = EasyLoadingStyle.dark
//     ..indicatorSize = 45.0
//     ..radius = 10.0
//     ..progressColor = Colors.yellow
//     ..backgroundColor = Colors.green
//     ..indicatorColor = Colors.yellow
//     ..textColor = Colors.yellow
//     ..maskColor = Colors.blue.withOpacity(0.5)
//     ..userInteractions = true
//     ..dismissOnTap = false;
//     //..customAnimation = CustomAnimation();
// }

initServices() async {
  print('starting services ...');
  await Get.putAsync(() => LocalStorageService().init());
  print('All services started...');
}

class TutorialOverlay extends ModalRoute<void> {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    overLayContext = context;
    // This makes sure that text and other content follows the material style
    return Material(
        type: MaterialType.transparency,
        // make sure that the overlay content is not cut off
        child: SafeArea(
          child: Center(
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.8)),
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildOverlayContent(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'This is a nice overlay',
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
          // RaisedButton(
          //   onPressed: () => Navigator.pop(context),
          //   child: Text('Dismiss'),
          // )
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class AncestorWidget extends InheritedWidget {
  final String data;

  const AncestorWidget({super.key, required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(AncestorWidget oldWidget) {
    return data != oldWidget.data;
  }

  static AncestorWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AncestorWidget>()!;
  }
}

class ChildWidget extends StatefulWidget {
  const ChildWidget({super.key});

  @override
  _ChildWidgetState createState() => _ChildWidgetState();
}

class _ChildWidgetState extends State<ChildWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ancestor = AncestorWidget.of(context);
    // Save a reference to the ancestor widget or perform any necessary operations
  }

  @override
  void dispose() {
    final ancestor = AncestorWidget.of(context);
    // Access the ancestor widget or perform any necessary cleanup
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
