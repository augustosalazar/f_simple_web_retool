import 'dart:convert';
import 'package:loggy/loggy.dart';
import '../../../domain/models/user.dart';
import 'package:http/http.dart' as http;

import 'i_user_datasource.dart';

class UserDataSource implements IUserDataSource {
  final http.Client httpClient;
  final String apiKey = 'qtDGZS';

  UserDataSource({http.Client? client}) : httpClient = client ?? http.Client();

  @override
  Future<List<User>> getUsers() async {
    List<User> users = [];
    var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
        .resolveUri(Uri(queryParameters: {
      "format": 'json',
    }));

    var response = await httpClient.get(request);

    if (response.statusCode == 200) {
      //logInfo(response.body);
      final data = jsonDecode(response.body);

      users = List<User>.from(data.skip(1).map((x) => User.fromJson(x)));
      //users.removeAt(1);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.error('Error code ${response.statusCode}');
    }

    return Future.value(users);
  }

  @override
  Future<bool> addUser(User user) async {
    logInfo("Web service, Adding user");

    final response = await httpClient.post(
      Uri.parse("https://retoolapi.dev/$apiKey/data"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> updateUser(User user) async {
    final response = await httpClient.put(
      Uri.parse("https://retoolapi.dev/$apiKey/data/${user.id}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }

  @override
  Future<bool> deleteUser(int id) async {
    final response = await httpClient.delete(
      Uri.parse("https://retoolapi.dev/$apiKey/data/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    logInfo("Deleting user with id $id status code ${response.statusCode}");
    if (response.statusCode == 200) {
      //logInfo(response.body);
      return Future.value(true);
    } else {
      logError("Got error code ${response.statusCode}");
      return Future.value(false);
    }
  }
}
