import '../../data/datasources/remote/user_datasource.dart';
import '../../domain/models/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../datasources/remote/i_user_datasource.dart';

class UserRepository implements IUserRepository {
  final IUserDataSource _userDatatasource;
  UserRepository(this._userDatatasource);

  @override
  Future<List<User>> getUsers() async => await _userDatatasource.getUsers();

  @override
  Future<bool> addUser(User user) async =>
      await _userDatatasource.addUser(user);
  @override
  Future<bool> updateUser(User user) async =>
      await _userDatatasource.updateUser(user);
  @override
  Future<bool> deleteUser(int id) async =>
      await _userDatatasource.deleteUser(id);
}
