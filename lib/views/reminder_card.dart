import 'package:aaaaa/utils/colors.dart';
import 'package:flutter/material.dart';

class ReminderCard extends StatefulWidget {
  const ReminderCard({super.key});

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: UtilColors.pColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              const Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/img/help.jpg'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Uhn nnhum',
                        style: TextStyle(color: UtilColors.tColor),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'bald',
                        style: TextStyle(color: UtilColors.tColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const TimeCard(),
              Container(
                width: 400,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: UtilColors.mColor,
                  ),
                  child: const Text('OK',
                      style: TextStyle(color: UtilColors.tColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimeCard extends StatelessWidget {
  const TimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: UtilColors.pColor,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          Icon(
            Icons.calendar_today_outlined,
            color: UtilColors.tColor,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'TODAY 99/99/9998',
            style: TextStyle(color: UtilColors.tColor),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.alarm,
            color: UtilColors.tColor,
            size: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Text(
              '99:99 pm',
              style: TextStyle(color: UtilColors.tColor),
            ),
          ),
        ],
      ),
    );
  }
}
