import 'package:contact_dairy/provider/contact_provider.dart';
import 'package:contact_dairy/provider/image_provider.dart';
import 'package:contact_dairy/provider/search_provider.dart';
import 'package:contact_dairy/provider/stepper_provder.dart';
import 'package:contact_dairy/provider/themeprovider.dart';
import 'package:contact_dairy/provider/updated_provider.dart';
import 'package:contact_dairy/view/detailPage.dart';
import 'package:contact_dairy/view/favourite_page.dart';
import 'package:contact_dairy/view/hide_contacts_page.dart';
import 'package:contact_dairy/view/homepage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => StepperProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Contctprovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => imageProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => Themeprovider(),
      ),
      ChangeNotifierProvider(
        create: (context) => hide(),
      ),
      ChangeNotifierProvider(
        create: (context) => SearchProvider(),
      ),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: (Provider.of<Themeprovider>(context).apptheme.isdark)
          ? ThemeMode.dark
          : ThemeMode.light,
      routes: {
        '/': (context) => Homepage(),
        'detailPage': (context) => detailPage(),
        'HidePage': (context) => HidePage(),
        'Favoutite': (context) => Favoutite(),
      },
    );
  }
}
