import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../../app/config/app_colors.dart';
import '../../../app/util/util.dart';
import '../../../generated/assets.dart';

typedef RecordCallback = void Function(String);

class RecordButton extends StatefulWidget {
  const RecordButton({
    Key? key,
    required this.recordingFinishedCallback,
  }) : super(key: key);

  final RecordCallback recordingFinishedCallback;

  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> {
  bool _isRecording = false;
  final _audioRecorder = Record();

  Future<void> _start() async {
    try {

      if (await _audioRecorder.hasPermission()) {
        //var pathh=await Utils.createFolder("eClass_sounds/"+DateTime.now().millisecond.toString()+"s.m4a");
        requestFileAccessPermission();
        //print(pathh);

        await _audioRecorder.start(path: pathToUrl(await Utils.getTemporaryFilePath()).path);

        bool isRecording = await _audioRecorder.isRecording();
        setState(() {
          _isRecording = isRecording;
        });

      }
    } catch (e) {
      print(e);
    }
  }

  Uri pathToUrl(String filePath) {
    final file = File(filePath);
    print("file.uri");
    print(file.uri.path);
    print("isFileExists${isFileExists(file.uri.path)}");
    return file.uri;
  }

  bool isFileExists(String filePath) {
    final file = File(filePath);
    return file.existsSync();
  }

  Future<void> requestFileAccessPermission() async {
    if (await Permission.storage.isGranted) {
      // Permission already granted
      return;
    }

    // Request permission
    final permissionStatus = await Permission.storage.request();

    if (permissionStatus.isGranted) {
      // Permission granted
      return;
    } else if (permissionStatus.isDenied) {
      // Permission denied
      // Handle denied case, e.g., show a dialog explaining the need for permission
    } else if (permissionStatus.isPermanentlyDenied) {
      // Permission permanently denied
      // Handle permanently denied case, e.g., show a dialog directing the user to app settings
    }
  }

  Future<void> _stop() async {
    final path = await _audioRecorder.stop();

    widget.recordingFinishedCallback(path!);

    setState(() => _isRecording = false);
  }

  @override
  Widget build(BuildContext context) {

    late final IconData icon;
    late final Color? color;
   late final Widget iconButton;
    if (_isRecording) {
      icon = Icons.stop;
      color = Colors.red.withOpacity(0.3);
      iconButton= Icon(
        icon,
        color: color,
      );
    } else {
      color = AppColors.primary;
      icon = Icons.mic;
      iconButton= SvgPicture.asset(Assets.imagesIcMic,color: AppColors.secoundry,);
    }
    return GestureDetector(
      onTap: () {
        _isRecording ? _stop() : _start();
      },
      child: iconButton/*Icon(
        icon,
        color: color,
      ),*/
    );
  }
}