import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: dicodingOffice,
        ),
        onMapCreated: (controller) {
          mapController = controller;
        },
      ),
    );
  }
}
