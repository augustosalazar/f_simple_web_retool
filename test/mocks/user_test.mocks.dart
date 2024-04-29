// Import the necessary Mockito and Build Runner packages
import 'package:f_simple_web_retool/data/datasources/remote/i_user_datasource.dart';
import 'package:f_simple_web_retool/domain/repositories/i_user_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

// run the build runner with the command:
// flutter pub run build_runner build

@GenerateMocks([IUserRepository])
@GenerateMocks([IUserDataSource])
@GenerateMocks([http.Client])
void main() {}
