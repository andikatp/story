import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/data/models/story_model.dart';

abstract class DashboardRemoteDataSource {
  const DashboardRemoteDataSource();

  Future<List<StoryModel>> getStories();
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  DashboardRemoteDataSourceImpl({required http.Client client})
      : _client = client;

  final http.Client _client;

  @override
  Future<List<StoryModel>> getStories() async {
    final url = Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.stories}');
    final response = await _client.get(url);
    final decode = jsonDecode(response.body) as ResultMap;

    if (response.statusCode != 200) {
      throw ServerException(message: decode['message'] as String);
    }
    final listStory = decode['listStory'] as List<ResultMap>;
    return listStory.map(StoryModel.fromJson).toList();
  }
}
