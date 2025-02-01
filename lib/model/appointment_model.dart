class Appointment {
  final String shopId;
  final String shopName;
  final String uId;
  final DateTime date;
  final String timeSlot;

  Appointment({
    required this.shopId,
    required this.shopName,
    required this.uId,
    required this.date,
    required this.timeSlot,
  });

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'shopName': shopName,
      'userId': uId,
      'date': date.toIso8601String(),
      'timeSlot': timeSlot,
    };
  }
}
