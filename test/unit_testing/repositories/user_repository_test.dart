import 'package:f_simple_web_retool/data/repositories/user_repository.dart';
import 'package:f_simple_web_retool/domain/models/user.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../mocks/user_test.mocks.mocks.dart';

void main() {
  late UserRepository userRepository;
  late MockIUserDataSource mockUserDataSource;

  setUp(() {
    mockUserDataSource = MockIUserDataSource();
    userRepository = UserRepository(mockUserDataSource);
  });

  group('UserRepository Tests', () {
    test('getUsers should retrieve users from the data source', () async {
      // Arrange
      when(mockUserDataSource.getUsers()).thenAnswer((_) async => <User>[]);

      // Act
      var users = await userRepository.getUsers();

      // Assert
      verify(mockUserDataSource.getUsers()).called(1);
      expect(users, isA<List<User>>());
    });
  });
  test('addUser should forward the addUser call to the data source', () async {
    // Arrange
    User newUser = User(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        email: 'johndoe@example.com');
    when(mockUserDataSource.addUser(any)).thenAnswer((_) async => true);

    // Act
    bool result = await userRepository.addUser(newUser);

    // Assert
    verify(mockUserDataSource.addUser(newUser)).called(1);
    expect(result, isTrue);
  });
  test('updateUser should forward the updateUser call to the data source',
      () async {
    // Arrange
    User updatedUser = User(
        id: 1,
        firstName: 'John',
        lastName: 'Smith',
        email: 'johnsmith@example.com');
    when(mockUserDataSource.updateUser(any)).thenAnswer((_) async => true);

    // Act
    bool result = await userRepository.updateUser(updatedUser);

    // Assert
    verify(mockUserDataSource.updateUser(updatedUser)).called(1);
    expect(result, isTrue);
  });
  test('deleteUser should forward the deleteUser call to the data source',
      () async {
    // Arrange
    int userId = 1;
    when(mockUserDataSource.deleteUser(any)).thenAnswer((_) async => true);

    // Act
    bool result = await userRepository.deleteUser(userId);

    // Assert
    verify(mockUserDataSource.deleteUser(userId)).called(1);
    expect(result, isTrue);
  });
}
