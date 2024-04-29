import 'package:f_simple_web_retool/data/datasources/remote/i_user_datasource.dart';
import 'package:f_simple_web_retool/domain/repositories/i_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import 'data/datasources/remote/user_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'domain/use_case/user_usecase.dart';
import 'ui/controller/user_controller.dart';
import 'ui/my_app.dart';

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put<IUserDataSource>(UserDataSource());
  Get.put<IUserRepository>(UserRepository(Get.find()));
  Get.put(UserUseCase(Get.find()));

  Get.put(UserController());
  runApp(const MyApp());
}
