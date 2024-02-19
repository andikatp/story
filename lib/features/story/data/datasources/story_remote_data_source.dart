import 'dart:convert';

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
    required bool isLocationAdded,
  });
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
    required bool isLocationAdded,
  }) async {
    final url = Uri.parse(
      '${AppConstant.baseUrl}${ApiEndpoint.stories}',
    );
    const lat = 0;
    const lon = 0;
    final request = http.MultipartRequest('POST', url);
    request.files.add(await http.MultipartFile.fromPath('photo', file.path));
    request.fields['description'] = description;
    request.fields['lat'] = lat.toString();
    request.fields['lon'] = lon.toString();

    final token = await getToken();
    request.headers['Authorization'] = 'Bearer $token';

    final streamedResponse = await _client.send(request);
    final response = await http.Response.fromStream(streamedResponse);

    final decode = jsonDecode(response.body) as ResultMap;
    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(AppConstant.tokenKey) ?? '';
  }
}
