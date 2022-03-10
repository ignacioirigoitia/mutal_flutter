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
  void initState() {
    super.initState();
    calcularLatLng("Argentina, chaco");
  }
  double? lat;
  double? lng;  

  Future<void> calcularLatLng(String ciudad) async {
    List<Location> locations = await locationFromAddress(ciudad);
    lat = locations[0].latitude;
    lng = locations[0].longitude;
    setState((){});
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;


    // Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add (const Marker(
      markerId: MarkerId('my-location'),
      position: LatLng(0.0, 0.0),
    ));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
      ),
      body:  ListView(
        children: [
          if(lng != null && lat != null)
            SizedBox(
              height: size.height - 70,
              child: GoogleMap(
                markers: markers,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(target: LatLng(lat!, lng!), zoom: 14),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
        ],
      ),
    );
  }
}
