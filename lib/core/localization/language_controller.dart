import 'package:flutter/material.dart';

class LanguageController {
  static final ValueNotifier<Locale> locale = ValueNotifier<Locale>(
    const Locale('tr'),
  );
}
