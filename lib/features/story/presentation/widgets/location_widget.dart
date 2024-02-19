import 'package:flutter/material.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({required this.setIsLocationOn, super.key});

  final void Function({required bool newValue}) setIsLocationOn;

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _isLocationOn = false;

  void setLocation() {
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
