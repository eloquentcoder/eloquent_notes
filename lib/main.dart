import 'package:elo_notes_app/screens/welcome_screen.dart';
import 'package:elo_notes_app/utils/theme_data.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      home: WelcomeScreen(),
    );
  }
}
