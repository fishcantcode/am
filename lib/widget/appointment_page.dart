import 'package:aaaaa/views/detail_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  late User? _user;
  List<Map<String, dynamic>> _appointments = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final QuerySnapshot querySnapshot = await _db
          .collection('appointments')
          .where('userId', isEqualTo: _user!.uid)
          .get();

      List<Map<String, dynamic>> appointments = [];
      querySnapshot.docs.forEach((doc) {
        appointments.add(doc.data() as Map<String, dynamic>);
      });

      setState(() {
        _appointments = appointments;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
    }
  }

  Future<void> cancel(String appointmentId) async {
    try {
      await _db.collection('appointments').doc(appointmentId).delete();
      setState(() {
        _appointments
            .removeWhere((appointment) => appointment['id'] == appointmentId);
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DetailBar(
        title: 'Appointments',
        icon: const FaIcon(Icons.arrow_back),
      ),
      body: _appointments.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _appointments.length,
              itemBuilder: (context, index) {
                var appointment = _appointments[index];
                String timeSlot = appointment['timeSlot'];
                String date = appointment['date'];
                String shopName = appointment['shopName'];
                String shopAddress = appointment['shopName'];

                DateTime dateTime = DateFormat('yyyy-MM-dd').parse(date);
                String formattedDate =
                    DateFormat('MMM dd, yyyy').format(dateTime);

                return ListTile(
                  title: Text('Appointment at $shopName'),
                  subtitle: Text('$formattedDate at $timeSlot\n$shopAddress'),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}
