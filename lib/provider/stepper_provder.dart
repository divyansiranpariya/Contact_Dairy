import 'dart:io';

import 'package:contact_dairy/model/contact.dart';
import 'package:contact_dairy/provider/contact_provider.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

class StepperProvider extends ChangeNotifier {
  int step = 0;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController contactcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? xFile;
  File? pickImagePath;
  Future<void> pickImage() async {
    xFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      pickImagePath = File(xFile!.path);
      notifyListeners();
    }
  }

  Future<void> pickImagecam() async {
    xFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (xFile != null) {
      pickImagePath = File(xFile!.path);
      notifyListeners();
    }
  }

  void forwordstep(BuildContext context) {
    if (step == 2) {
      Contact contact = Contact(
        name: namecontroller.text,
        contact: contactcontroller.text,
        email: emailcontroller.text,
        ima: pickImagePath,
      );

      Provider.of<Contctprovider>(context, listen: false)
          .addconatctfun(contact);
      print(
          "${Provider.of<Contctprovider>(context, listen: false).allconatct[0].name}");
      Navigator.of(context).pop(context);
    }
    if (step < 2) {
      step++;
    }
    notifyListeners();
  }

  void backwordstep() {
    if (step > 0) {
      step--;
    }
    notifyListeners();
  }
}
