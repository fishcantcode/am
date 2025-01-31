import 'package:aaaaa/views/reminder_card.dart';
import 'package:aaaaa/views/shop_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String username;
  fetch() async {
    final user = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).get().then((value){
      setState(() {
        username = value.data()?['username'];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hello,',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/img/icon.jpg'),
                    ),
                  ),
                ],
              ),
              FutureBuilder(future: fetch(), builder: (context,snapshot){
                return Text(username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
              ),
              SizedBox(
                height: 40,
              ),
              const Text(
                'Reminder',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              ReminderCard(),
              SizedBox(
                height: 40,
              ),
              const Text(
                'Recommend',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Column(
                children: List.generate(10, (index) {
                  return const ShopCard(
                    route: 'shop_details',
                  );
                }),
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: UtilColors.mColor,
                    ),
                  ),
                  Text(
                    'Stay tuned for more',
                    style: TextStyle(
                      color: UtilColors.tColor,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: UtilColors.mColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
