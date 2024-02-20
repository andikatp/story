import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/features/story/presentation/bloc/story_bloc.dart';

class LocationMapPage extends StatefulWidget {
  const LocationMapPage({super.key});

  @override
  State<LocationMapPage> createState() => _LocationMapPageState();
}

class _LocationMapPageState extends State<LocationMapPage> {
  late GoogleMapController mapController;
  late final Set<Marker> markers = {};
  final dicodingOffice = const LatLng(-6.8957473, 107.6337669);
  String address = '';

  void getUserPosition() =>
      context.read<StoryBloc>().add(const GetLocationEvent());

  void defineMarker(LatLng latLng) {
    final markerId = UniqueKey().toString();
    final marker = Marker(
      markerId: MarkerId(markerId),
      position: latLng,
    );
    setState(() {
      markers
        ..clear()
        ..add(marker);
    });
  }

  Future<void> onLongPressGoogleMap(LatLng latLng) async {
    await getAddress(latLng.latitude, latLng.longitude);
    defineMarker(latLng);
    await mapController.animateCamera(
      CameraUpdate.newLatLng(latLng),
    );
  }

  Future<void> getAddress(double lat, double lon) async {
    try {
      final placeMarks = await placemarkFromCoordinates(lat, lon);
      if (placeMarks.isNotEmpty) {
        setState(() {
          address = '${placeMarks[0].street} ${placeMarks[0].subLocality}, '
              '${placeMarks[0].locality}';
        });
      }
    } catch (e) {
      debugPrint('Error getting address: $e');
    }
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    final marker = Marker(
      markerId: const MarkerId('dicoding'),
      position: dicodingOffice,
      onTap: () {
        controller.animateCamera(
          CameraUpdate.newLatLngZoom(dicodingOffice, 18),
        );
      },
    );
    await getAddress(
      dicodingOffice.latitude,
      dicodingOffice.longitude,
    );
    setState(() {
      mapController = controller;
      markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: BlocListener<StoryBloc, StoryState>(
        listener: (context, state) async {
          if (state is StoryError) {
            context.messengger.clearSnackBars();
            context.messengger.showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is LocationObtained) {
            final location = state.location;
            final userPosition = LatLng(location.latitude, location.longitude);
            await getAddress(userPosition.latitude, userPosition.longitude);
            defineMarker(userPosition);
            await mapController.animateCamera(
              CameraUpdate.newLatLng(userPosition),
            );
          }
        },
        child: Padding(
          padding: REdgeInsets.symmetric(vertical: Sizes.p40),
          child: FloatingActionButton(
            onPressed: getUserPosition,
            backgroundColor: Colours.primaryColor,
            child: const Icon(Icons.my_location),
          ),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: dicodingOffice,
              zoom: 18,
            ),
            markers: markers,
            myLocationEnabled: true,
            onLongPress: onLongPressGoogleMap,
            onMapCreated: onMapCreated,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapToolbarEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colours.backgroundColor,
                  width: 1.sw,
                  padding: REdgeInsets.all(Sizes.p12),
                  child: Text(address),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (markers.isNotEmpty) {
                      final firstMarker = markers.first;
                      final lat = firstMarker.position.latitude;
                      final lon = firstMarker.position.longitude;
                      context.pop(LatLng(lat, lon));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colours.whiteColor,
                    shape: const BeveledRectangleBorder(),
                  ),
                  child: const Text('LocationButton').tr(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
