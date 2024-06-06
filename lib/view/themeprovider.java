import 'package:counter/modal/apptheme.dart';
import 'package:flutter/material.dart';

class themeprovider extends ChangeNotifier {
  Apptheme apptheme = Apptheme(isdark: false);

  void changetheme(bool value) {
    apptheme.isdark = value;
    notifyListeners();
  }
}