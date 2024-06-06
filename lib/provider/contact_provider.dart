import 'package:contact_dairy/model/contact.dart';
import 'package:flutter/material.dart';

class Contctprovider extends ChangeNotifier {
  List<Contact> allconatct = [];

  void addconatctfun(Contact contact) {
    allconatct.add(contact);
    notifyListeners();
  }

  void removeconatctfun(Contact contact) {
    allconatct.remove(contact);
    notifyListeners();
  }

  void updated(Contact contact) {}
}
