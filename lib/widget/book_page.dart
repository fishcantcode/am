import 'package:aaaaa/views/detail_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../utils/colors.dart';

class BookPage extends StatefulWidget {
  const BookPage({super.key});

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex;
  bool _isWeekend = false;
  bool _selectedDate = false;
  bool _selectedTime = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailBar(
        title: 'Booking',
        icon: const FaIcon(Icons.arrow_back),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                Calendar(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: Center(
                    child: Text(
                      'Select Time Slot',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                      _selectedTime = true;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _currentIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: _currentIndex == index ? UtilColors.pColor : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 11}:00 ${index + 11 >= 12 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _currentIndex == index ? Colors.white : null,
                      ),
                    ),
                  ),
                );
              },
              childCount: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 70),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _selectedTime && _selectedDate ? () {
                      Navigator.of(context).pushNamed('booking_successful');
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: UtilColors.pColor,
                      foregroundColor: UtilColors.tColor,
                    ),
                    child: Text(
                      'Book',
                      style: const TextStyle(
                        fontFamily: 'Mitr',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }

  Widget Calendar() {
    return TableCalendar(
      focusedDay: _focusDay,
      firstDay: DateTime.now(),
      lastDay: DateTime(2026, 12, 31),
      calendarFormat: _format,
      currentDay: _currentDay,
      calendarStyle: const CalendarStyle(
        todayDecoration:
            BoxDecoration(color: UtilColors.pColor, shape: BoxShape.circle),
      ),
      availableCalendarFormats: const {CalendarFormat.month: 'Month'},
      onFormatChanged: (format) {
        setState(() {
          _format = format;
        });
      },
      onDaySelected: ((selectedDay, focusedDay) {
        setState(() {
          _currentDay = selectedDay;
          _focusDay = focusedDay;
          _selectedDate = true;
        });
      }),
    );
  }
}
