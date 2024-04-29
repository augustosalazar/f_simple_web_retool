import 'package:f_simple_web_retool/domain/models/user.dart';
import 'package:f_simple_web_retool/domain/use_case/user_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/user_test.mocks.mocks.dart';

// Mock class
//class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  //late MockUserRepository mockUserRepository;
  late MockIUserRepository mockUserRepository;
  late UserUseCase userUseCase;

  setUp(() {
    mockUserRepository = MockIUserRepository();
    userUseCase = UserUseCase(mockUserRepository);
  });

  group('getUsers', () {
    test('should call getUsers on the repository', () async {
      // Arrange
      when(mockUserRepository.getUsers()).thenAnswer((_) async => <User>[]);

      // Act
      await userUseCase.getUsers();

      // Assert
      verify(mockUserRepository.getUsers()).called(1);
    });
  });

  group('addUser', () {
    test('should call addUser on the repository with correct data', () async {
      // Arrange
      User dummyUser = User(
          firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com');
      when(mockUserRepository.addUser(dummyUser)).thenAnswer((_) async => true);

      // Act
      await userUseCase.addUser(dummyUser);

      // Assert
      verify(mockUserRepository.addUser(dummyUser)).called(1);
    });
  });

  group('updateUser', () {
    test('should call updateUser on the repository with correct data',
        () async {
      // Arrange
      User dummyUser = User(
          firstName: 'John', lastName: 'Doe', email: 'john.doe@example.com');
      when(mockUserRepository.updateUser(dummyUser))
          .thenAnswer((_) async => true);

      // Act
      await userUseCase.updateUser(dummyUser);

      // Assert
      verify(mockUserRepository.updateUser(dummyUser)).called(1);
    });
  });

  group('deleteUser', () {
    test('should return true on successful deletion', () async {
      // Arrange
      int userId = 1;
      // Ensure to return a Future that completes with a boolean
      when(mockUserRepository.deleteUser(userId)).thenAnswer((_) async => true);

      // Act
      bool result = await userUseCase.deleteUser(userId);

      // Assert
      verify(mockUserRepository.deleteUser(userId)).called(1);
      expect(result, isTrue);
    });
  });
}
