import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:payments/repos/login_repo.dart';
import 'package:payments/repos/nativelogin_repo.dart';
import 'package:payments/viewmodel/native_response.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository repository;

  LoginViewModel({LoginRepository? repository})
      : repository = repository ?? NativeLoginRepository();

  bool isLoading = false;
  String? error;
  String? token;

  Future<String?> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final NativeResponse loginResponse =
          await repository.login(username, password);

      debugPrint("$username, login response: ${loginResponse.data}");

      if (loginResponse.success == true && loginResponse.data != null) {
        try {
          final Map<String, dynamic> decoded = loginResponse.data is String
              ? json.decode(loginResponse.data.toString())
              : Map<String, dynamic>.from(loginResponse.data as Map);
          token = decoded['accessToken']?.toString() ??
              decoded['token']?.toString() ??
              decoded['access_token']?.toString();
        } catch (e) {
          error = 'Invalid login response format';
          return null;
        }

        if (token == null) {
          error = 'Login succeeded but token not found';
          return null;
        }

        error = null;
        return token;
      } else {
        error = 'Login failed! Please try again.';
        return null;
      }
    } catch (e) {
      error = e.toString();
      return null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    error = null;
    notifyListeners();
  }
}

// class LoginViewModel extends ChangeNotifier {
//   bool isLoading = false;
//   String? error;
//   String? token;

//   Future<String?> login(String username, String password) async {
//     isLoading = true;
//     error = null;
//     notifyListeners();

//     try {
//       final NativeResponse loginResponse =
//           await NativeService.login(username, password);

//       debugPrint("$username, login response: ${loginResponse.data}");

//       if (loginResponse.success == true && loginResponse.data != null) {
//         try {
//           final Map<String, dynamic> decoded = loginResponse.data is String
//               ? json.decode(loginResponse.data.toString())
//               : Map<String, dynamic>.from(loginResponse.data as Map);
//           token = decoded['accessToken']?.toString() ??
//               decoded['token']?.toString() ??
//               decoded['access_token']?.toString();
//         } catch (e) {
//           error = 'Invalid login response format';
//           return null;
//         }

//         if (token == null) {
//           error =
//               loginResponse.message ?? 'Login succeeded but token not found';
//           return null;
//         }

//         error = null;
//         return token;
//       } else {
//         error = 'Login failed! Please try again.';
//         return null;
//       }
//     } catch (e) {
//       error = e.toString();
//       return null;
//     } finally {
//       isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearError() {
//     error = null;
//     notifyListeners();
//   }
// }
