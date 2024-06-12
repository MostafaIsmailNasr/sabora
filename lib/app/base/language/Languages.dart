import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initLanguages() async {
    final _keys = await readJson();
    Get.clearTranslations();
    Get.addTranslations(_keys);
  }

  static Future<Map<String, Map<String, String>>> readJson() async {
    final res = await rootBundle.loadString('assets/languages.json');
    List<dynamic> data = jsonDecode(res);
    final listData = data.map((j) => I18nModel.fromJson(j)).toList();
    final keys = Map<String, Map<String, String>>();
    listData.forEach((value) {
      final String translationKey = value.texts.toString();
      keys.addAll({translationKey: value.texts!});
    });
    return keys;
  }
}


class I18nModel {

  Map<String, String>? texts;

  I18nModel(
      {this.texts});

  I18nModel.fromJson(Map<String, dynamic> json) {
      texts = Map<String, String>.from(json);

  }
}