import 'package:aaaaa/main_layout.dart';
import 'package:aaaaa/services/check_auth.dart';
import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/global.dart';
import 'package:aaaaa/widget/book_page.dart';
import 'package:aaaaa/widget/book_success.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: snackBarKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Mitr', scaffoldBackgroundColor: UtilColors.background),
      initialRoute: '/',
      routes: {
        '/': (context) => checkAuth(),
        'main': (context) => const mLayout(),
        'booking': (context) => const BookPage(),
        'booking_successful': (context) => const BookSuccess(),
      },
    );
  }
}
