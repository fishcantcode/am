import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/login_auth.dart';

class UserLoginPage extends StatefulWidget {
  const UserLoginPage({super.key});

  @override
  State<UserLoginPage> createState() => _UserLoginPageState();
}

class _UserLoginPageState extends State<UserLoginPage> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _emailAddress;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _emailAddress = TextEditingController();
    _password = TextEditingController();
    loadCredentials();
  }

  Future<void> loadCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _emailAddress.text = prefs.getString('email') ?? '';
      _password.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', _emailAddress.text);
    await prefs.setString('password', _password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _emailAddress,
            keyboardType: TextInputType.emailAddress,
            cursorColor: UtilColors.pColor,
            decoration: const InputDecoration(
                labelText: 'Email Address',
                hintText: 'abc@example.com',
                alignLabelWithHint: true),
            style: TextStyle(color: UtilColors.tColor),
            onChanged: (value) => saveCredentials(),
          ),
          TextFormField(
            controller: _password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            cursorColor: UtilColors.pColor,
            decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
                alignLabelWithHint: true),
            style: TextStyle(color: UtilColors.tColor),
            onChanged: (value) => saveCredentials(),
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    await loginAuth().login(
                        email: _emailAddress.text,
                        password: _password.text,
                        context: context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.pColor,
                    foregroundColor: UtilColors.tColor,
                  ),
                  child: Text(
                    'Login',
                    style: const TextStyle(
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  )))
        ],
      ),
    );
  }
}
