import 'package:contact_dairy/model/contact.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contact_provider.dart';

class hide extends ChangeNotifier {
  List<Contact> hidecontact = [];

  void addcontacts(Contact contact) {
    hidecontact.add(contact);
    notifyListeners();
  }

  void removecontacts(Contact contact) {
    hidecontact.remove(contact);
    notifyListeners();
  }
}
