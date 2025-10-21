import 'package:payments/viewmodel/native_response.dart';

abstract class LoginRepository {
  Future<NativeResponse> login(String username, String password);
}
