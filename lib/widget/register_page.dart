import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';
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
            Text(
              '',
              style: const TextStyle(
                  fontFamily: 'Mitr',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: UtilColors.tColor
              ),
            ),
            RegisterLoginPage(),
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
