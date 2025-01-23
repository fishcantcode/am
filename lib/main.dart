import 'package:flutter/material.dart';
import 'widget/HomePage.dart';
import 'widget/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Mitr'),
        initialRoute: '/',
      routes: {
          '/':(context) => const LoginPage(),
        'main': (context) => const HomePage(),
      },
    );
  }
}

