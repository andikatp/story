import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/features/story/data/datasources/story_remote_data_source.dart';
import 'package:story/features/story/data/repositories/story_repository_impl.dart';
import 'package:story/features/story/domain/repositories/story_repository.dart';
import 'package:story/features/story/domain/usecases/add_story.dart';

class MockStoryRemoteDataSource extends Mock implements StoryRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late StoryRepository repository;
  late NetworkInfo mockNetworkInfo;
  late StoryRemoteDataSource mockStoryRemoteDataSource;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockStoryRemoteDataSource = MockStoryRemoteDataSource();
    repository = StoryRepositoryImpl(
      dataSource: mockStoryRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
    registerFallbackValue(XFile(''));
  });

  final tParams = AddStoryParams.empty();

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    // act
    await repository.addStory(
      file: tParams.file,
      description: tParams.description,
      location: tParams.location,
    );
    // assert
    expect(false, await mockNetworkInfo.isConnected);
  });

  group('addStory', () {
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    test(
        'Should call [MockStoryRemoteDataSource.addStory] '
        'and return a Right data', () async {
      // arrange
      when(
        () => mockStoryRemoteDataSource.addStory(
          file: any(named: 'file'),
          description: any(named: 'description'),
          location: any(named: 'location'),
        ),
      ).thenAnswer((_) => Future.value());
      // act
      final result = await repository.addStory(
        file: tParams.file,
        description: tParams.description,
        location: tParams.location,
      );
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => mockStoryRemoteDataSource.addStory(
          file: tParams.file,
          description: tParams.description,
          location: tParams.location,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockStoryRemoteDataSource);
    });

    test(
        'Should call [MockStoryRemoteDataSource.addStory] '
        'and return a Left data', () async {
      // arrange
      when(
        () => mockStoryRemoteDataSource.addStory(
          file: any(named: 'file'),
          description: any(named: 'description'),
          location: any(named: 'location'),
        ),
      ).thenThrow(tException);
      // act
      final result = await repository.addStory(
        file: tParams.file,
        description: tParams.description,
        location: tParams.location,
      );
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(ServerFailure.fromException(tException)),
        ),
      );
      verify(
        () => mockStoryRemoteDataSource.addStory(
          file: tParams.file,
          description: tParams.description,
          location: tParams.location,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockStoryRemoteDataSource);
    });
  });
}
