import '../../../domain/models/user.dart';

abstract class IUserDataSource {
  Future<List<User>> getUsers();

  Future<bool> addUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);
}
