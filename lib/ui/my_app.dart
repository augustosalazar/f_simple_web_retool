import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/content/user_list_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserListPage(),
    );
  }
}
