import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/res/colours.dart';

class MapPage extends StatelessWidget {
  const MapPage({required this.location, super.key});
  final LatLng location;

  @override
  Widget build(BuildContext context) {
    Future<String?> getAddress(double lat, double lon) async {
      if (await Permission.locationWhenInUse.isDenied) {
        await Permission.locationWhenInUse.request();
      }
      final placeMarks = await placemarkFromCoordinates(lat, lon);
      return '${placeMarks[0].street} ${placeMarks[0].subLocality}, '
          '${placeMarks[0].locality}';
    }

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              zoom: 18,
              target: location,
            ),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
            markers: {
              Marker(
                markerId: const MarkerId('user1'),
                position: location,
              ),
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colours.backgroundColor,
              width: 1.sw,
              padding: REdgeInsets.all(Sizes.p12),
              child: FutureBuilder(
                future: getAddress(location.latitude, location.longitude),
                builder: (_, snapshot) => Text(snapshot.data ?? ''),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
