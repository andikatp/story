import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/utils/typedef.dart';

abstract class StoryRemoteDataSource {
  const StoryRemoteDataSource();

  Future<void> addStory({
    required XFile file,
    required String description,
    required LatLng? location,
  });

  Future<Position> getLocation();
}

class StoryRemoteDataSourceImpl extends StoryRemoteDataSource {
  StoryRemoteDataSourceImpl({
    required http.Client client,
    required SharedPreferences sharedPreferences,
  })  : _client = client,
        _sharedPreferences = sharedPreferences;

  final http.Client _client;
  final SharedPreferences _sharedPreferences;

  @override
  Future<void> addStory({
    required XFile file,
    required String description,
    required LatLng? location,
  }) async {
    final url = Uri.parse(
      '${AppConstant.baseUrl}${ApiEndpoint.stories}',
    );
    final lat = location?.latitude;
    final lon = location?.longitude;
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', file.path));
    request.fields['description'] = description;
    request.fields['lat'] = lat.toString();
    request.fields['lon'] = lon.toString();

    final token = await _getToken();
    request.headers['Authorization'] = 'Bearer $token';

    final streamedResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    final decode = jsonDecode(response.body) as ResultMap;
    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
  }

  Future<String> _getToken() async {
    return _sharedPreferences.getString(AppConstant.tokenKey) ?? '';
  }

  @override
  Future<Position> getLocation() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const ServerException(message: 'Location services are disabled.');
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw const ServerException(message: 'Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw const ServerException(
        message: 'Location permissions are permanently denied, '
            'we cannot request permissions.',
      );
    }
    return Geolocator.getCurrentPosition();
  }
}
