import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../widget/home_page.dart';
class registerAuth {


  Future<void> register({
    required String email,
    required String password,
    required BuildContext context,
}) async {
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => const HomePage()
          )
      );
    } on FirebaseAuthException catch(e){
      String errorMessage = '';
      if (e.code == 'email-already-in-use'){
        errorMessage = 'Email Already In Use';
      } else if(e.code =='weak-password'){
        errorMessage = 'Password Is Too Weak';
      }
      final snackbar = SnackBar(
      backgroundColor: UtilColors.sColor,
      behavior: SnackBarBehavior.floating,
      content: Text(errorMessage),
      //content: Text('NOM ONOM NOMN ONM NOM'),
      action: SnackBarAction(
        label: 'OK',
        textColor: UtilColors.tColor,
        onPressed: (){},
      )
    );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
    catch (e){
      rethrow;
    }
  }
}