import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  const MapPage({required this.location, super.key});
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          zoom: 18,
          target: location,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('user1'),
            position: location,
          ),
        },
      ),
    );
  }
}
