import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // 🔥

import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teching App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Aplica Poppins a todos los textos
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        // Opcional: también al appBar, botones, etc.
        primaryTextTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).primaryTextTheme,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PracticeHomeScreen(),
    );
  }
}
