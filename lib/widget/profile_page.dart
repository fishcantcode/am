import 'package:aaaaa/widget/appointment_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../views/addshop_card.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100), child: const Image(image: AssetImage('assets/img/help.jpg')),
                ),
              ),
              const SizedBox(height: 10,),
              FutureBuilder(future: fetch(), builder: (context,snapshot){
                return Text(username,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
              ),
              const SizedBox(height: 50,),
              const Divider(),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddShopScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.mColor,
                  ),
                  child: const Text('Add Barber',
                      style: TextStyle(color: UtilColors.tColor)),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.mColor,
                  ),
                  child: const Text('View Appointments',
                      style: TextStyle(color: UtilColors.tColor)),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.mColor,
                  ),
                  child: const Text('AI chatbot',
                      style: TextStyle(color: UtilColors.tColor)),
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () async {
                    await logout();
                    Navigator.of(context).pushReplacementNamed('/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.mColor,
                  ),
                  child: const Text('Log out',
                      style: TextStyle(color: UtilColors.tColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
