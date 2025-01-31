class Shop {
  final String id;
  final String name;
  final num  phone;
  final String address;
  final String? imageUrl;
  final num  latitude;
  final num  longitude;
  final String description;

  Shop({
    required this.id,
    required this.name,
    required this.phone,
    required this.imageUrl,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.description,
  });


  factory Shop.fromMap(Map<String, dynamic> map) => Shop(
    id: map['id'],
    name: map['name'],
    phone: map['phone'],
    address: map['address'] ,
    imageUrl: map['imageUrl'],
    latitude: map['latitude'],
    longitude: map['longitude'],
    description: map['description'],
  );
}
