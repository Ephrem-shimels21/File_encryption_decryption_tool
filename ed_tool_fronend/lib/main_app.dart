import 'package:flutter/material.dart';

import 'login.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromARGB(255, 236, 230, 219),
        ),
      ),
      home: const Login(),
    );
  }
}
