import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({required this.setIsLocationOn, super.key});

  final void Function({required LatLng? location}) setIsLocationOn;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _isLocationOn = false;

  Future<void> setLocation() async {
    final location =
        await context.pushNamed<LatLng>(Routes.addLocationStory.name);
    if (location != null && context.mounted) {
      context.messengger.hideCurrentSnackBar();
      context.messengger.showSnackBar(
        const SnackBar(
          content: Text('Location has been added!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
    setState(() => _isLocationOn = location != null);
    widget.setIsLocationOn(location: location);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: setLocation,
      icon: Icon(_isLocationOn ? Icons.location_on : Icons.location_off),
    );
  }
}
