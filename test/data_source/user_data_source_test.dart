import 'package:f_simple_web_retool/data/datasources/remote/user_datasource.dart';
import 'package:f_simple_web_retool/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../mocks/user_test.mocks.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late UserDataSource dataSource; // Same for dataSource
  const String apiKey = 'qtDGZS'; // Ensure apiKey is properly declared

  group('UserDataSource Tests', () {
    final Uri usersUri = Uri.parse("https://retoolapi.dev/$apiKey/data");
    const String usersJson =
        '[{"id":1,"firstName":"John","lastName":"Doe","email":"john.doe@example.com"},{"id":2,"firstName":"John","lastName":"Doe","email":"john.doe@example.com"}]';
    final mockHttpClient = MockClient();
    dataSource = UserDataSource(client: mockHttpClient);
    test('getUsers returns a list of users on a successful call', () async {
      var request = Uri.parse("https://retoolapi.dev/$apiKey/data")
          .resolveUri(Uri(queryParameters: {
        "format": 'json',
      }));

      when(mockHttpClient.get(request))
          .thenAnswer((_) async => http.Response(usersJson, 200));

      final result = await dataSource.getUsers();

      expect(result, isA<List<User>>());
      expect(result.first.firstName, equals('John'));
    });

    test('addUser returns true when a user is successfully added', () async {
      when(mockHttpClient.post(Uri.parse("https://retoolapi.dev/$apiKey/data"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 201));

      bool result = await dataSource.addUser(User(
          id: null, // Ensure handling of null here if your User class requires it
          firstName: 'Jane',
          lastName: 'Doe',
          email: 'jane.doe@example.com'));

      expect(result, isTrue);
    });

    test('updateUser returns true when a user is successfully updated',
        () async {
      when(mockHttpClient.put(Uri.parse("https://retoolapi.dev/$apiKey/data/1"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.updateUser(User(
          id: 1,
          firstName: 'Jane',
          lastName: 'Doe',
          email: 'jane.update@example.com'));

      expect(result, isTrue);
    });

    test('deleteUser returns true when a user is successfully deleted',
        () async {
      when(mockHttpClient.delete(
          Uri.parse("https://retoolapi.dev/$apiKey/data/1"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          })).thenAnswer((_) async => http.Response('', 200));

      bool result = await dataSource.deleteUser(1);

      expect(result, isTrue);
    });
  });
}
