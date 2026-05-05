import 'package:flutter/material.dart';

class LocalizationManager with ChangeNotifier {
  String languageCode;
  LocalizationManager(this.languageCode);

  static const String defaultLanguageCode = "en";

  final Map<String, Map<String, String>> _mapLanguages = {
    "pt": {
      "clearBooksText": "Limpar todos os livros.",
      "languageText": "Idioma",
      "deviceStandardText": "Padrão do Dispositivo",
      "cleanText": "Limpar",
    },
    "en": {
      "clearBooksText": "Clear all books.",
      "languageText": "Language",
      "deviceStandardText": "Device standard",
      "cleanText": "Clear",
    },
    "es": {
      "clearBooksText": "Eliminar todos los libros.",
      "languageText": "Idioma",
      "deviceStandardText": "Estándar del dispositivo",
      "cleanText": "Limpiar",
    },
  };

  String _getSentence(String keySentence) {
    String? sentence = _mapLanguages[languageCode]?[keySentence];

    sentence ??= _mapLanguages[defaultLanguageCode]![keySentence];

    return sentence!;
  }

  String get clearBookText => _getSentence("clearBooksText");
  String get languageText => _getSentence("languageText");
  String get deviceStandardText => _getSentence("deviceStandardText");
  String get cleanText => _getSentence("cleanText");

  setLanguage(String newCode) {
    languageCode = newCode;
    notifyListeners();
  }
}
