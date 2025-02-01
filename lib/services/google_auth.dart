import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/colors.dart';
import '../utils/global.dart';

class GoogleAuth {
  Future<User?> signInWithGoogle(BuildContext context) async {
    User? user;
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth;
    if (gUser != null) {
      gAuth = await gUser!.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      try {
        UserCredential userCred =
            await FirebaseAuth.instance.signInWithCredential(cred);

        user = userCred.user;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user?.uid)
            .set({'username': 'google login user', 'email': user?.email}).then(
                (value) => Navigator.of(context).pushNamed('main'));
      } on FirebaseAuthException catch (e) {
        String errorMessage = '';
        if (e.code == 'account-exists-with-different-credential') {
          errorMessage = 'Already exist, use another email';
        }
        final snackbar = SnackBar(
            backgroundColor: UtilColors.sColor,
            behavior: SnackBarBehavior.floating,
            content: Text(errorMessage),
            //content: Text('NOM ONOM NOMN ONM NOM'),
            action: SnackBarAction(
              label: 'OK',
              textColor: UtilColors.tColor,
              onPressed: () {},
            ));
        snackBarKey.currentState?.showSnackBar(snackbar);
      }
      return user;
    }
  }
}
