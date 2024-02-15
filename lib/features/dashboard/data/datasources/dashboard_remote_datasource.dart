import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/data/models/story_model.dart';

abstract class DashboardRemoteDataSource {
  const DashboardRemoteDataSource();

  Future<List<StoryModel>> getStories({required int page});

  Future<void> addStory({
    required XFile file,
    required String description,
    double lat,
    double lon,
  });
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl({
    required SharedPreferences sharedPreferences,
    required http.Client client,
  })  : _client = client,
        _sharedPreferences = sharedPreferences;

  final http.Client _client;
  final SharedPreferences _sharedPreferences;

  @override
  Future<List<StoryModel>> getStories({required int page}) async {
    final url = Uri.parse(
      '${AppConstant.baseUrl}${ApiEndpoint.stories}?page=$page&&size=20',
    );
    final token = await getToken();
    final response = await _client.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );
    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != AppConstant.successfulHttpGetStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    final listStory = decode['listStory'] as List<dynamic>;
    return listStory
        .map((story) => StoryModel.fromJson(story as ResultMap))
        .toList();
  }

  @override
  Future<void> addStory({
    required XFile file,
    required String description,
    double? lat,
    double? lon,
  }) async {
    final url = Uri.parse(
      '${AppConstant.baseUrl}${ApiEndpoint.stories}',
    );
    final body = {
      'description': description,
      'photo': File(file.path),
      'lat': 0,
      'lon': 0,
    };
    final token = await getToken();
    final response = await _client.post(
      url,
      body: body,
      headers: {
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token()',
      },
    );
    final decode = jsonDecode(response.body) as ResultMap;
    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(AppConstant.tokenKey) ?? '';
  }
}
