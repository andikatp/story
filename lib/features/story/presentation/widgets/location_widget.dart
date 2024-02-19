import 'package:flutter/material.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({required this.setIsLocationOn, super.key});

  final void Function({required bool newValue}) setIsLocationOn;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _isLocationOn = false;

  void setLocation() {
    context.messengger.clearSnackBars();
    context.messengger.showSnackBar(
      SnackBar(
        content: Text(
          _isLocationOn ? 'Location Disabled..' : 'Location Enabled',
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 300),
        backgroundColor: Colours.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() => _isLocationOn = !_isLocationOn);
    widget.setIsLocationOn(newValue: _isLocationOn);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: setLocation,
      icon: Icon(_isLocationOn ? Icons.location_on : Icons.location_off),
    );
  }
}
