import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aaaaa/main_layout.dart';
import 'package:aaaaa/widget/login_page.dart';

class checkAuth extends StatelessWidget {
  const checkAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          return const mLayout();
        }
        return const LoginPage();
      },
    );
  }
}