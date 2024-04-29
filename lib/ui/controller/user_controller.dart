import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/models/user.dart';
import '../../domain/use_case/user_usecase.dart';

class UserController extends GetxController {
  final RxList<User> _users = <User>[].obs;
  final UserUseCase userUseCase = Get.find();

  List<User> get users => _users;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  void getUsers() async {
    logInfo("Getting users");
    _users.value = await userUseCase.getUsers();
  }

  void addUser(User user) async {
    logInfo("Add user");
    await userUseCase.addUser(user);
    getUsers();
  }

  void updateUser(User user) async {
    logInfo("Update user");
    await userUseCase.updateUser(user);
    getUsers();
  }

  void deleteUser(int id) async {
    logInfo("deleteUser user $id");
    await userUseCase.deleteUser(id);
    getUsers();
  }
}
