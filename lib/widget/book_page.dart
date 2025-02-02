import 'package:aaaaa/views/detail_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../model/shop_model.dart';
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
  bool _selectedDate = false;
  bool _selectedTime = false;
  Set<String> _bookedSlots = {};
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> fetchBookedSlots() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    String date = DateFormat('yyyy-MM-dd').format(_currentDay);

    try {
      QuerySnapshot querySnapshot = await db
          .collection('appointments')
          .where('date', isEqualTo: date)
          .get();

      Set<String> bookedSlots = {};
      querySnapshot.docs.forEach((doc) {
        bookedSlots.add(doc['timeSlot']);
      });

      setState(() {
        _bookedSlots = bookedSlots;
      });
    } catch (e) {
      print('Error fetching booked time slots: $e');
    }
  }

  Future<bool> authFingerprint() async {
    bool authSuccess = false;
    try {
      authSuccess = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to confirm the booking.',
        options: AuthenticationOptions(biometricOnly: true),
      );
    } on PlatformException catch (e) {
      print('Fingerprint authentication error: $e');
    }
    return authSuccess;
  }

  Future<void> bookAppointment(Shop shop) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = auth.currentUser;
    String? userId = user?.uid;
    String timeSlot =
        '${_currentIndex! + 11}:00 ${_currentIndex! + 11 >= 12 ? "PM" : "AM"}';
    String date = DateFormat('yyyy-MM-dd').format(_currentDay);
    bool authSuccess = await authFingerprint();

    if (authSuccess) {
      try {
        await db.collection('appointments').add({
          'shopId': shop.id,
          'shopName': shop.name,
          'userId': userId,
          'date': date,
          'timeSlot': timeSlot,
        });
        Navigator.of(context).pushNamed('booking_successful');
      } catch (e) {
        print('Error: $e');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please try again")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Shop shop = ModalRoute.of(context)!.settings.arguments as Shop;
    return Scaffold(
      appBar: DetailBar(
        title: 'Booking for ${shop.name} at ${shop.address}',
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
                String timeSlot =
                    '${index + 11}:00 ${index + 11 >= 12 ? "PM" : "AM"}';
                bool isBooked = _bookedSlots.contains(timeSlot);

                return InkWell(
                  splashColor: Colors.transparent,
                  onTap: isBooked
                      ? null
                      : () {
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
                            : isBooked
                                ? Colors.grey
                                : Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: _currentIndex == index
                          ? UtilColors.pColor
                          : isBooked
                              ? Colors.grey
                              : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 11}:00 ${index + 11 >= 12 ? "PM" : "AM"}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _currentIndex == index || isBooked
                            ? Colors.white
                            : null,
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
                    onPressed: _selectedTime && _selectedDate
                        ? () {
                            bookAppointment(shop);
                            //Navigator.of(context).pushNamed('booking_successful');
                          }
                        : null,
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
          fetchBookedSlots();
        });
      }),
    );
  }
}
