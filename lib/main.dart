//import 'package:cleanup/ui/home_screen.dart';
import 'package:cleanup/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              GoogleFonts.workSansTextTheme(Theme.of(context).textTheme)),
    );
  }
}
