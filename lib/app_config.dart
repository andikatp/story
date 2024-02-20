import 'package:flutter/material.dart';

enum Flavor { free, paid }

class AppConfig {
  AppConfig(this.appName, this.flavor);

  factory AppConfig.create({
    String appName = '',
    Flavor flavor = Flavor.free,
  }) {
    return shared = AppConfig(appName, flavor);
  }
  String appName = '';
  MaterialColor primaryColor = Colors.blue;
  Flavor flavor = Flavor.paid;

  static AppConfig shared = AppConfig.create();
}
