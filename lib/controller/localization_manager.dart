import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  final Map<String, Map<String, String>> _mapLanguages = {
    "pt": {
      "clearBooksText": "Limpar todos os livros",
      "languageText": "Idioma",
      "clearButton": "Limpar",
      "defaultDeviceLanguageItem": "Do dispositivo",
      "homeTitle": "Grimório",
      "homeEmpty": "Seu Grimório está vazio",
      "homeEmptyCall": "Vamos aprender algo novo?"
    },
    "en": {
      "clearBooksText": "Clear all books",
      "languageText": "Languages",
      "clearButton": "Erase Books",
      "defaultDeviceLanguageItem": "From device",
      "homeTitle": "Spellbook",
      "homeEmpty": "Your spellbook is empty",
      "homeEmptyCall": "Let's learn something new?"
    },
    "es": {
      "clearBooksText": "Eliminar todos los libros",
      "languageText": "Idioma",
      "clearButton": "Limpiar",
      "defaultDeviceLanguageItem": "Del dispositivo",
      "homeTitle": "Grimorio",
      "homeEmpty": "Tu Grimorio está vacío",
      "homeEmptyCall": "¿Aprendemos algo nuevo?"
    },
  };

  Future<void> setLanguage(String newCode) async {
    await _getLanguageFromServer(newCode);
    languageCode = newCode;

    notifyListeners();
  }

  Future<void> _getLanguageFromServer(String newCode) async {
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
}
