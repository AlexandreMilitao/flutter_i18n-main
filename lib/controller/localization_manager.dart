import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  final Map<String, Map<String, String>> _mapLanguages = {};

  Future<void> setLanguage(String newCode) async {
    await getLanguageFromServer(newCode);
    languageCode = newCode;

    notifyListeners();
  }

  Future<void> getLanguageFromServer(String newCode) async {
    try {
      String url =
          "https://gist.githubusercontent.com/AlexandreMilitao/3a5aa7e0dd859a81d9ace7ccca57b250/raw/b941b7a3563c3f5702ce1474d6a1a1b1505ac6b7/app_$newCode.json";
      http.Response httpResponse = await http.get(Uri.parse(url));
      Map<String, dynamic> response = json.decode(httpResponse.body);

      _mapLanguages[newCode] = response.map(
        (key, value) => MapEntry(
          key,
          value.toString(),
        ),
      );
    } catch (e) {
      debugPrint("Deu ruim: $e");
    }
  }

  String _getSentence(String keySentence) {
    String? sentence = _mapLanguages[languageCode]?[keySentence];

    sentence ??= _mapLanguages[defaultLanguageCode]![keySentence]!;

    return sentence;
  }

  String get clearBookText => _getSentence("clearBooksText");
  String get languageText => _getSentence("languageText");
  String get defaultDeviceLanguageItem =>
      _getSentence("defaultDeviceLanguageItem");
  String get clearButton => _getSentence("clearButton");
  String get homeTitle => _getSentence("homeTitle");
  String get homeEmpty => _getSentence("homeEmpty");
  String get homeEmptyCall => _getSentence("homeEmptyCall");
}
