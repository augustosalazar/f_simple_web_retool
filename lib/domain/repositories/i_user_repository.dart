import '../../data/datasources/remote/i_user_datasource.dart';
import '../models/user.dart';

abstract class IUserRepository {
  final IUserDataSource _userDatatasource;

  IUserRepository(this._userDatatasource);

  Future<List<User>> getUsers();

  Future<bool> addUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);
}
