import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';

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
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key : _formkey,
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
              alignLabelWithHint: true
            ),
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your email address';
              }
              return null;
            },
              style: TextStyle(color: UtilColors.tColor)
          ),
          TextFormField(
            controller: _password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            cursorColor: UtilColors.pColor,
            decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Password',
              alignLabelWithHint: true
            ),
            validator: (value){
              if (value == null || value.isEmpty){
                return 'Please enter your email address';
              }
              return null;
            },
              style: TextStyle(color: UtilColors.tColor)
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () async{
              await loginAuth().login(
                  email: _emailAddress.text,
                  password: _password.text,
                  context: context
              );
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

                )
              )
            )
          ],
        ),
      );
    }
  }
