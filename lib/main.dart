import 'package:flutter/material.dart';
import 'package:vibepick/presentation/screens/splash_screen.dart';
import 'package:vibepick/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vibe Pick',
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}
