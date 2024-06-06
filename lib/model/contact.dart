import 'dart:io';

import 'package:flutter/material.dart';

class Contact {
  String name;
  String contact;
  String email;
  File? ima;

  Contact({
    required this.name,
    required this.contact,
    required this.email,
    this.ima,
  });
}
