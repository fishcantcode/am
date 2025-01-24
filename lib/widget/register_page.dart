import 'package:aaaaa/widget/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/google_auth.dart';
import '../views/register.dart';
import 'login_page.dart';
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: SafeArea(child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Register',
              style: const TextStyle(
                fontFamily: 'Mitr',
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            RegisterLoginPage(),

            const SizedBox(height: 30), //space
            Row(
              children: [
                Expanded(child: Divider(
                  thickness: 0.5,
                  color: UtilColors.mColor,
                ),
                ),
                Text('Or Sign with',
                  style:TextStyle(
                    color: UtilColors.tColor,
                  ),
                ),
                Expanded(child: Divider(
                  thickness: 0.5,
                  color: UtilColors.mColor,
                ),
                ),
              ],
            ),
            const SizedBox(height: 20), //space
            Center(child:
            ElevatedButton.icon(style: ElevatedButton.styleFrom(
                  backgroundColor: UtilColors.sColor,
                  foregroundColor: UtilColors.tColor,
              ),
                  onPressed:() async {
                    User? user;
                    user = await GoogleAuth().signInWithGoogle();
                    if (user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const HomePage(),));
                    } else {

                    }
                  },
                  icon: FaIcon(FontAwesomeIcons.google, color: UtilColors.tColor),
                  label: Text('Sign up with Google',
                  style: const TextStyle(
                    fontFamily: 'Mitr',
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30), //spkeyace
            Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                      'Click here to login',
                      style: const TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: UtilColors.tColor,
                      )
                  ),
                )
            ),
          ],
        )
        ),
      ),
    );
  }
}
