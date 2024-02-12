import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:story/features/dashboard/data/models/story_model.dart';
import 'package:story/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:story/features/dashboard/domain/repositories/dashboard_repository.dart';

class MockDashboardRemoteDataSource extends Mock
    implements DashboardRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late NetworkInfo mockNetworkInfo;
  late DashboardRemoteDataSource mockRemoteDataSource;
  late DashboardRepository repository;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockRemoteDataSource = MockDashboardRemoteDataSource();
    repository = DashboardRepositoryImpl(
      networkInfo: mockNetworkInfo,
      dataSource: mockRemoteDataSource,
    );
  });

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    // act
    await repository.getStories();
    // assert
    expect(false, await mockNetworkInfo.isConnected);
  });

  group('remote', () {
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    final tList = [const StoryModel.empty()];
    test(
        'Should call [MockDashboardRemoteDataSourceImpl.getStories] '
        'and return a Right data', () async {
      // arrange
      when(() => mockRemoteDataSource.getStories())
          .thenAnswer((_) async => tList);
      // act
      final result = await repository.getStories();
      // assert
      expect(result, equals(Right<dynamic, List<StoryModel>>(tList)));
      verify(() => mockRemoteDataSource.getStories()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test(
        'Should call [MockDashboardRemoteDataSourceImpl.getStories] '
        'and return a Server Failure when failed', () async {
      // arrange
      when(() => mockRemoteDataSource.getStories()).thenThrow(tException);
      // act
      final result = await repository.getStories();
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        ),
      );
      verify(() => mockRemoteDataSource.getStories()).called(1);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
