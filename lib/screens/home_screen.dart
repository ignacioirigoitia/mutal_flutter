import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final LatLng address = ModalRoute.of(context)!.settings.arguments as LatLng;

    // Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(const Marker(
      markerId: MarkerId('my-location'),
      position: LatLng(0.0, 0.0),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body: GoogleMap(
        markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: address, zoom: 20),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
