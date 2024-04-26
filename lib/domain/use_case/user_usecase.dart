import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../models/user.dart';
import '../repositories/i_user_repository.dart';

class UserUseCase {
  final IUserRepository _repository;

  UserUseCase(this._repository);

  Future<List<User>> getUsers() async {
    logInfo("Getting users  from UseCase");
    return await _repository.getUsers();
  }

  Future<void> addUser(User user) async => await _repository.addUser(user);

  Future<void> updateUser(User user) async =>
      await _repository.updateUser(user);

  deleteUser(int id) async => await _repository.deleteUser(id);
}