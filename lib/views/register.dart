import 'package:aaaaa/services/register_auth.dart';
import 'package:flutter/material.dart';
import 'package:aaaaa/utils/colors.dart';

class RegisterLoginPage extends StatefulWidget {
  const RegisterLoginPage({super.key});

  @override
  State<RegisterLoginPage> createState() => _RegisterLoginPageState();
}

class _RegisterLoginPageState extends State<RegisterLoginPage> {
  final _formkey = GlobalKey<FormState>();
  late final TextEditingController _emailAddress;
  late final TextEditingController _username;
  late final TextEditingController _password;
  late final TextEditingController _repeatedPassword;
  late final BuildContext context;
  @override
  void initState() {
    // TODO: implement initState
    _emailAddress = TextEditingController();
    _password = TextEditingController();
    _repeatedPassword = TextEditingController();
    _username = TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key : _formkey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
              controller: _username,
              keyboardType: TextInputType.name,
              cursorColor: UtilColors.pColor,
              decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username',
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
              style: TextStyle(color: UtilColors.tColor)
          ),
          TextFormField(
              controller: _repeatedPassword,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              cursorColor: UtilColors.pColor,
              decoration: const InputDecoration(
                  labelText: 'Re-enter password',
                  hintText: 'Type your password again',
                  alignLabelWithHint: true
              ),
              style: TextStyle(color: UtilColors.tColor)
          ),
          SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () async{
                await
                registerAuth().register(
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
                    'Register',
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
