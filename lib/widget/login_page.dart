import 'package:aaaaa/widget/register_page.dart';
import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';
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
                  color: UtilColors.tColor
                ),
              ),
              UserLoginPage(),
              Center(
                  child: TextButton(
                      onPressed: (){},
                      child: Text(
                        'Forget your password? Click here',
                        style: const TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xFF274C77),
                      )
                  ),
                )
              ), Center(
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                        'Click here to register',
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
