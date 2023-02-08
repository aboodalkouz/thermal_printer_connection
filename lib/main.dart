import 'package:flutter/material.dart';
import 'package:printer_connect/screens/mainPage.dart';
import 'package:printer_connect/screens/methodOne.dart';
import 'package:printer_connect/screens/methodTwo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainPage(),
      routes: {
        "mainpage":(context) => mainPage(),
        "methodone" : (context) => methodOne(),
        "methodtwo" : (context) => methodTwo(),

      },
    );
  }
}
