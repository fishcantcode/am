import 'package:aaaaa/views/reminder_card.dart';
import 'package:aaaaa/views/shop_card.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
        ),
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
                    Text(
                      'Name',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage:
                        AssetImage('assets/img/icon.jpg'),
                      ),
                    ),
                  ],
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
                ShopCard()
              ],
            ),
        ),
      )
    );
  }
}
