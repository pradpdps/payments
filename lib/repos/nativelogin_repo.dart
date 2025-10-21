import 'package:payments/repos/login_repo.dart';
import 'package:payments/utils/native_service.dart';
import 'package:payments/viewmodel/native_response.dart';

class NativeLoginRepository implements LoginRepository {
  @override
  Future<NativeResponse> login(String username, String password) {
    return NativeService.login(username, password);
  }
}
