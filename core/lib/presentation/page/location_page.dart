import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../notifier/location_model.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> markers = <Marker>{};

  late LocationModel model;

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  void requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Position>(
          future: getCurrentLocation(),
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return GoogleMap(
                onMapCreated: onMapCreated,
                markers: markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(snapshot.data!.latitude, snapshot.data!.longitude),
                  zoom: 14.0,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<Position> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      markers.clear(); // Clear previous markers

      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'Lokasi Kamu'),
        ),
      );

      getNearbyHospitals(position.latitude, position.longitude);
    });

    return position;
  }

  void getNearbyHospitals(double latitude, double longitude) async {
    String apiKey = 'YOUR_API_KEY'; // Ganti dengan API Key Google Maps Anda
    int radius = 5000;

    String apiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=hospital&key=$apiKey';

    var response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List results = data['results'];

        for (var result in results) {
          var location = result['geometry']['location'];
          var lat = location['lat'];
          var lng = location['lng'];
          var name = result['name'];

          markers.add(
            Marker(
              markerId: MarkerId(name),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: name),
            ),
          );
        }
      }
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }
}
