import 'package:aaaaa/utils/screen_adapter.dart';
import 'package:aaaaa/views/shop_card.dart';
import 'package:aaaaa/widget/shop_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/shop_model.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Shop> _shops = [];
  late String username;

  fetch() async {
    final user = await FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      setState(() {
        username = value.data()?['username'];
      });
    });
  }

  void initState() {
    super.initState();
    print('HONK');
    fetchShops();
    fetch();
  }

  bool usernameExist() {
    if (username != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> fetchShops() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('shops').get();

      List<Shop> tmpShops = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> shopData = doc.data() as Map<String, dynamic>;
        shopData['id'] = doc.id;
        Shop shop = Shop.fromMap(shopData);
        tmpShops.add(shop);
        print("Fetched Shops: $tmpShops");
      }
      setState(() {
        _shops = tmpShops;
      });
    } catch (error) {
      print("Error fetching shops: $error");
    }
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
                        backgroundImage: AssetImage('assets/img/help.jpg'),
                      ),
                    ),
                  ],
                ),
                usernameExist()
                    ? Text(
                        username,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    : Text('Not available'),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 40,
                ),
                const Text(
                  'Shop list',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      itemCount: _shops.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShopDetail(shop: _shops[index]),
                              ),
                            );
                          },
                          child: ShopCard(
                            name: _shops[index].name,
                            address: _shops[index].address,
                            imageUrl: _shops[index].imageUrl ?? "",
                            phone: _shops[index].phone,
                          ),
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
      ),
    );
  }
}
