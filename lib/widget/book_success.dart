import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/colors.dart';

class BookSuccess extends StatefulWidget {
  const BookSuccess({super.key});

  @override
  State<BookSuccess> createState() => _BookSuccessState();
}

class _BookSuccessState extends State<BookSuccess> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Lottie.asset('assets/anim/success.json', repeat: false),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Booking Successful!',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('main');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.pColor,
                    foregroundColor: UtilColors.tColor,
                  ),
                  child: Text(
                    'OK',
                    style: const TextStyle(
                      fontFamily: 'Mitr',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                )),
          )
        ],
      )),
    );
  }
}
