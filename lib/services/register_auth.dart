import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/colors.dart';
//import '../widget/home_page.dart';

class registerAuth {
  //final _db = FirebaseFirestore.instance;
  late SnackBar snackbar;
  Future<void> register({
    required String email,
    required String password,
    required String username,
    required BuildContext context,

  }) async {
    try {
      final userInfo = <String, dynamic>{
      "username": username,
      "email": email,
    };
      UserCredential userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      var user = await FirebaseAuth.instance.currentUser!;
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username,
          'email': email
        }).then((value) => Navigator.of(context).pushNamed('main'));


      }
     on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'email-already-in-use') {
        errorMessage = 'Email Already In Use';
      } else if (e.code == 'weak-password') {
        errorMessage = 'Password Is Too Weak';
      } else {
        errorMessage = 'Something went wrong';
      }
      snackbar = SnackBar(
          backgroundColor: UtilColors.sColor,
          behavior: SnackBarBehavior.floating,
          content: Text(errorMessage),
          //content: Text('NOM ONOM NOMN ONM NOM'),
          action: SnackBarAction(
            label: 'OK',
            textColor: UtilColors.tColor,
            onPressed: () {},
          ));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      rethrow;
    }
  }
}
