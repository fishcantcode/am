import 'package:aaaaa/main_layout.dart';
import 'package:aaaaa/utils/colors.dart';
import 'package:aaaaa/utils/global.dart';
import 'package:aaaaa/widget/book_page.dart';
import 'package:aaaaa/widget/book_success.dart';
import 'package:aaaaa/widget/shop_detail.dart';
import 'package:flutter/material.dart';
import 'widget/home_page.dart';
import 'widget/login_page.dart';
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
        '/': (context) => const LoginPage(),
        'main': (context) => const mLayout(),
        'shop_details': (context) => const ShopDetail(),
        'booking': (context) => const BookPage(),
        'booking_successful': (context) => const BookSuccess(),
      },
    );
  }
}
