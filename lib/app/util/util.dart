import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

typedef AttachFileCallback = void Function(dynamic);

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static String getFormatedDate(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }

  // static final drawerController = ZoomDrawerController();

  /// ImgSource.Both
  /// ImgSource.Camera
  /// ImgSource.Gallery
  ///
  static Future<dynamic> getImage(
      BuildContext context, ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        enableCloseButton: true,
        closeIcon: const Icon(
          Icons.close,
          color: Colors.red,
          size: 12,
        ),
        context: context,
        source: source,
        barrierDismissible: true,
        cameraIcon: const Icon(
          Icons.camera_alt,
          color: Colors.red,
        ),
        //cameraIcon and galleryIcon can change. If no icon provided default icon will be present
        cameraText: const Text(
          "From Camera",
          style: TextStyle(color: Colors.red),
        ),
        galleryText: const Text(
          "From Gallery",
          style: TextStyle(color: Colors.blue),
        ));
    return image;
  }

  // Get storage directory paths
  static Future<dynamic> getPath_1() async {
    var path = await ExternalPath.getExternalStorageDirectories();
    print(path); // [/storage/emulated/0, /storage/B3AE-4D28]
    return path[0];
    // please note: B3AE-4D28 is external storage (SD card) folder name it can be any.
  }

  static Future<String> createFolder(String cow) async {
    final dir = Directory((Platform.isAndroid
                ? await getExternalStorageDirectory() //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )!
            .path +
        '/$cow');
    var status = await Permission.storage.status;
    // if (!status.isGranted) {
    await Permission.storage.request();
    //}
    if ((await dir.exists())) {
      return dir.path;
    } else {
      Directory(dir.path).create();
      // dir.createTempSync();
      return dir.path;
    }
  }

  static Future<void> openUrl(Uri _url) async {
    print("_url");
    print(_url);
    if (Platform.isAndroid) {
      const platform = MethodChannel('e_class.course.com/muteMic');

      await platform.invokeMethod('openUrl', _url.toString());
    } else {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    }
  }

  static Future<void> viewFile(Uri _url) async {
    const platform = MethodChannel('e_class.course.com/muteMic');
    print("_url");
    print(_url);
    // if(Platform.isAndroid) {

    await platform.invokeMethod('viewFile', _url.path.toString());
    // }else{
    // if (!await launchUrl(_url)) {
    //   throw Exception('Could not launch $_url');
    // }
    //}
  }

  static Future<dynamic> getUrlFileSize(Uri url) async {
    http.Response r = await http.head(url);
    return r.headers["content-length"];
  }

  static pickFile(AttachFileCallback attachFileCallback) async {
    FilePickerResult? pickerResult = await FilePicker.platform.pickFiles();

    if (pickerResult != null) {
      File attachedFile = File(pickerResult.files.single.path!);
      attachFileCallback(attachedFile);
    } else {
      // User canceled the picker
    }
  }

  // This function is triggered when the floating button gets pressed
  static Future<String> getDeviceInfo(BuildContext context) async {
    // // Instantiating the plugin
    // final deviceInfoPlugin = DeviceInfoPlugin();
    //
    // final result = await deviceInfoPlugin.deviceInfo;
    // print("device_info");
    // print(result);
    // Map? _info = result.data;
    // _info!.entries
    //     .forEach((e) =>{
    //   print("device_info"),
    //       print(e)
    // });

    // Instantiate the DeviceInfoPlugin
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

// Get the device information
    String deviceId;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      print("ios");
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "unknown"; // For iOS
    } else {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.fingerprint; // For Android
    }

// Print the deviceId
    print('Device Id: $deviceId');
    return deviceId;
  }

  static Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName.png';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  static Future<String> createDynamicLink(bool short, String courseID) async {
    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

    String DynamicLink =
        'http://elsabora.com/course_details?courseID=$courseID';
    const String Link = 'https://https://elsabora.page.link';

    // setState(() {
    //   _isCreatingLink = true;
    // });


    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://elsabora.page.link',
      longDynamicLink: Uri.parse(
        'https://elsabora.page.link?efr=0&ibi=com.sabora.app_flutter&apn=com.sabora.app_flutter&imv=0&amv=0&link=$DynamicLink&ofl=https://ofl-example.com',
      ),
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'com.sabora.app_flutter',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'com.sabora.app_flutter',
        minimumVersion: '0',
      ),
    );
    

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    // setState(() {
    //   _linkMessage = url.toString();
    //   _isCreatingLink = false;
    // });
    Share.share(' شوف الحصة على السبورة ${url.toString()}');

    return url.toString();
  }

  static Future<String> getTemporaryFilePath() async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    String tempFilePath = '$tempPath/soundFile.m4a'; // Example file name
    return tempFilePath;
  }
}
