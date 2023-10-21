import 'package:yeshelpinghand/core/presentation/resources/ui_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Language {
  int id;
  String title;
  String image;
  String languageCode;
  String countryCode;

  Language({
    required this.id,
    required this.title,
    required this.image,
    required this.languageCode,
    required this.countryCode,
  });
}

class LanguageController extends GetxController {
  int _selectedLanguageId = 0;

  set selectedLanguageId(int value) {
    _selectedLanguageId = value;
    update();
  }

  int get selectedLanguageId => _selectedLanguageId;

  List<Language> languages = [
    Language(
      id: 0,
      image: UIAssets.getImage("us.png"),
      title: "English",
      languageCode: 'en',
      countryCode: 'US',
    ),
    Language(
      id: 1,
      image: UIAssets.getImage("dubai.png"),
      title: "عربي",
      languageCode: 'ar',
      countryCode: 'DU',
    ),
  ];

  void confirmLanguage() {
    final selectedLanguage = languages
        .where((element) => element.id == selectedLanguageId)
        .toList()[0];
    makeLocale(selectedLanguage.languageCode, selectedLanguage.countryCode);
  }

  void makeLocale(String languageCode, String countryCode) async {
    Locale locale = Locale(languageCode, countryCode);
    await Get.updateLocale(locale);
  }
}
