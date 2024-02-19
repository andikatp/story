import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story/core/constants/app_sizes.dart';

class LocationMapPage extends StatefulWidget {
  const LocationMapPage({super.key});

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: 'zoom-in',
            onPressed: () => mapController.animateCamera(CameraUpdate.zoomIn()),
            child: const Icon(Icons.add),
          ),
          FloatingActionButton.small(
            heroTag: 'zoom-out',
            onPressed: () =>
                mapController.animateCamera(CameraUpdate.zoomOut()),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: dicodingOffice,
                zoom: 18,
              ),
              markers: markers,
              myLocationEnabled: true,
              onMapCreated: (controller) {
                final marker = Marker(
                  markerId: const MarkerId('dicoding'),
                  position: dicodingOffice,
                  onTap: () {
                    controller.animateCamera(
                      CameraUpdate.newLatLngZoom(dicodingOffice, 18),
                    );
                  },
                );
                setState(() {
                  mapController = controller;
                  markers.add(marker);
                });
              },
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              mapToolbarEnabled: false,
            ),
            Positioned(
              top: Sizes.p20,
              right: Sizes.p20,
              child: FloatingActionButton(
                child: const Icon(Icons.my_location),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
