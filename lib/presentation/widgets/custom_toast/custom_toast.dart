import '../../../app/config/app_text_styles.dart';
import '../../../generated/assets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToastMContext {
  BuildContext? context;
  MethodChannel? _channel;

  static final ToastMContext _instance = ToastMContext._internal();

  /// Prmary Constructor for FToast
  factory ToastMContext() {
    return _instance;
  }

  /// Take users Context and saves to avariable
  ToastMContext init(BuildContext context) {
    _instance.context = context;
    return _instance;
  }

  ToastMContext._internal();
}

class Toast {
  static const int lengthShort = 1;
  static const int lengthLong = 3;
  static const int bottom = 0;
  static const int center = 1;
  static const int top = 2;
  static void show(String msg,
      String? title,
      {int? duration = 1,
        int? gravity = 0,
        bool? isSuccess ,
        Color backgroundColor = const Color(0xAA000000),
        textStyle = const TextStyle(fontSize: 15, color: Colors.black),
        double backgroundRadius = 20,
        bool? rootNavigator,
        Border? border,
        bool webShowClose = false,
        Color webTexColor = const Color(0xFFffffff)}) {
    if (ToastMContext().context == null) {
      throw Exception('Context is null, please call ToastMContext.init(context) first');
    }
    if (kIsWeb == true) {
      if (ToastMContext()._channel == null) {
        ToastMContext()._channel = const MethodChannel('appdev/FlutterToast');
      }
      String toastGravity = "bottom";
      if (gravity == Toast.top) {
        toastGravity = "top";
      } else if (gravity == Toast.center) {
        toastGravity = "center";
      } else {
        toastGravity = "bottom";
      }

      final Map<String, dynamic> params = <String, dynamic>{
        'msg': msg,
        'duration': (duration ?? 1) * 3000,
        'gravity': toastGravity,
        'bgcolor': backgroundColor.toString(),
        'textcolor': webTexColor.value.toRadixString(16),
        'webShowClose': webShowClose,
      };
      ToastMContext()._channel?.invokeMethod("showToast", params);
    } else {
      ToastView.dismiss();
      ToastView.createView(msg,title??"", ToastMContext().context!, duration, gravity, backgroundColor,
          textStyle, backgroundRadius, border, rootNavigator,isSuccess);
    }
  }
}

class ToastView {
  static final ToastView _singleton = ToastView._internal();

  factory ToastView() {
    return _singleton;
  }

  ToastView._internal();

  static OverlayState? overlayState;
  static OverlayEntry? _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,
      String title,
      BuildContext context,
      int? duration,
      int? gravity,
      Color background,
      TextStyle textStyle,
      double backgroundRadius,
      Border? border,
      bool? rootNavigator,
       bool? isSuccess ,) async {

    overlayState = Overlay.of(context, rootOverlay: rootNavigator ?? false);
print("isSuccess");
print(isSuccess);
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
          widget: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(backgroundRadius),
                    border: border,
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    SvgPicture.asset((isSuccess??true)?Assets.imagesCorrect:Assets.imagesError),
                    const SizedBox(width: 15,),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text(title, softWrap: true, style:AppTextStyles.title),
                        Text(msg, softWrap: true, style: AppTextStyles.title2)
                      ],),
                    )
                  ],),
                )),
          ),
          gravity: gravity),
    );
    _isVisible = true;
    overlayState!.insert(_overlayEntry!);
    await Future.delayed(Duration(seconds: duration ?? Toast.lengthShort));
    dismiss();
  }

  static dismiss() async {
    if (!_isVisible) {
      return;
    }
    _isVisible = false;
    _overlayEntry?.remove();
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    Key? key,
    required this.widget,
    required this.gravity,
  }) : super(key: key);

  final Widget widget;
  final int? gravity;

  @override
  Widget build(BuildContext context) {
    ToastMContext().init(context);
    
    return Positioned(
        top: gravity == 2 ? MediaQuery.of(context).viewInsets.top + 50 : null,
        bottom: gravity == 0 ? MediaQuery.of(context).viewInsets.bottom + 50 : null,
        child: IgnorePointer(
          child: Material(
            color: Colors.transparent,
            child: widget,
          ),
        ));
  }
}
