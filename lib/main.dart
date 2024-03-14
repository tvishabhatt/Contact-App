import 'package:contact_app_final/Splace_Screen.dart';
import 'package:contact_app_final/ThemeProvider.dart';
import 'package:contact_app_final/android_contact.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactList.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  final ContactListprovider=ContactList();
  final themeProvider=ThemeProvider();
  await themeProvider.loadThemePrefrence();
  await themeProvider.loadThemevalue();

  await ContactListprovider.loadContacts();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => forvalues(),),
      ChangeNotifierProvider<ContactList>.value(value: ContactListprovider),
      ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),

    ],
        child:MyApp(),),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/addContact': (context) => android_contact(),
      },
      home:Splace_Screen(),


    );
  }
}


