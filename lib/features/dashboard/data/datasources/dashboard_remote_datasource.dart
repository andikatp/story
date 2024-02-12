import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/data/models/story_model.dart';

abstract class DashboardRemoteDataSource {
  const DashboardRemoteDataSource();

  Future<List<StoryModel>> getStories({required int page});
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

    if (response.statusCode != 200) {
      throw ServerException(message: decode['message'] as String);
    }
    final listStory = decode['listStory'] as List<dynamic>;
    return listStory
        .map((story) => StoryModel.fromJson(story as ResultMap))
        .toList();
  }

  Future<String> getToken() async {
    return _sharedPreferences.getString(AppConstant.tokenKey) ?? '';
  }
}
