class Shop {
  late String id;
  late String name;
  late String phone;
  late String address;
  late String imageUrl;
  late double latitude;
  late double longitude;

  Shop({
    required this.id,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() => {
  'id': id,
  'name': name,
  'phone': phone,
    'imageUrl': imageUrl,
    'latitude': latitude,
    'longitude': longitude,
  };

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    id: json['id'],
    name: json['name'],
    phone: json['phone'],
    imageUrl: json['imageUrl'],
    latitude: json['latitude'],
    longitude: json['longitude'],
  );
}
