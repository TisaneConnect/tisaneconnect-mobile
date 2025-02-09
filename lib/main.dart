import 'package:flutter/material.dart';

import 'package:tisaneconnect/app/navigation.dart';
import 'package:tisaneconnect/ui/pages/admin/home/home.dart';

import 'package:tisaneconnect/ui/pages/auth/splash_screen.dart';
import 'package:tisaneconnect/ui/pages/operasional/home/home.dart';
import 'package:tisaneconnect/ui/pages/operasional/summary/summary.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins",
      ),
      navigatorKey: nav.nk,
      home: const SplashScreen(),
    );
  }
}
