import 'package:flutter/material.dart';

import '../model/apptheme.dart';
import '../model/contact.dart';

class Themeprovider extends ChangeNotifier {
  Apptheme apptheme = Apptheme(isdark: false);

  changetheme() {
    apptheme.isdark = !apptheme.isdark;
    notifyListeners();
  }

  favourite fav = favourite(isfav: false);
  List<Contact> allfav = [];

  favouriteadd(Contact contact) {
    fav.isfav = !fav.isfav;
    if (fav.isfav == true) {
      allfav.add(contact);
    }
    notifyListeners();
  }

  favouriteremove(Contact contact) {
    fav.isfav = !fav.isfav;
    if (fav.isfav == false) {
      allfav.remove(contact);
    }
    notifyListeners();
  }
}
