import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapView extends StatefulWidget {
  final num latitude;
  final num longitude;

  const MapView({super.key, required this.latitude, required this.longitude});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late GoogleMapController mapController;
  LocationData? _currentLocation;
  late Location _location;
  Set<Marker> _markers = {};

  void initState() {
    super.initState();
    _location = Location();

    requestPerm();
  }

  void requestPerm() async {
    var permStat = await _location.hasPermission();
    if (permStat == PermissionStatus.denied) {
      permStat = await _location.requestPermission();
    }

    if (permStat == PermissionStatus.granted) {
      getCurrLoc();
    }
  }

  void getCurrLoc() async {
    LocationData currLocation = await _location.getLocation();
    setState(() {
      _currentLocation = currLocation;
      print('Current Latitude: ${currLocation.latitude}');
      print('Current Longitude: ${currLocation.longitude}');
      // Add marker for the shop location
      _markers.add(Marker(
        markerId: const MarkerId('shop_location'),
        position:
            LatLng(widget.latitude.toDouble(), widget.longitude.toDouble()),
        infoWindow: const InfoWindow(title: 'Shop'),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    //print("Latitude: ${widget.latitude}, Longitude: ${widget.longitude}");
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target:
              LatLng(widget.latitude.toDouble(), widget.longitude.toDouble()),
          zoom: 18,
        ),
        onMapCreated: (GoogleMapController controller) {
          mapController = controller;
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
      ),
    );
  }
}
