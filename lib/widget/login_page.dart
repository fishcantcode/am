import 'package:aaaaa/widget/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/google_auth.dart';
import '../views/login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sign in',
              style: const TextStyle(
                fontFamily: 'Mitr',
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            Text(
              'Welcome back!',
              style: const TextStyle(
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: UtilColors.tColor),
            ),
            UserLoginPage(),
            Center(
                child: TextButton(
              onPressed: () {},
              child: Text('Forget your password? Click here',
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xFF274C77),
                  )),
            )),
            const SizedBox(height: 30), //space
            Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: UtilColors.mColor,
                  ),
                ),
                Text(
                  'Or Sign with',
                  style: TextStyle(
                    color: UtilColors.tColor,
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                    color: UtilColors.mColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), //space
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: UtilColors.sColor,
                  foregroundColor: UtilColors.tColor,
                ),
                onPressed: () async {
                  User? user;
                  user = await GoogleAuth().signInWithGoogle(context);
                  if (user != null) {
                    Navigator.of(context).pushNamed('main');
                  } else {}
                },
                icon: FaIcon(FontAwesomeIcons.google, color: UtilColors.tColor),
                label: Text(
                  'Sign up with Google',
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), //space
            Center(
                child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text('Click here to register',
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: UtilColors.tColor,
                  )),
            )),
          ],
        )),
      ),
    );
  }
}
