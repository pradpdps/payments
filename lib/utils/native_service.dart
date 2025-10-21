import 'package:flutter/services.dart';
import '../viewmodel/native_response.dart';

class NativeService {
  static final platform = MethodChannel('com.example.myapp/native');

  static Future<NativeResponse> getProducts(String accessToken) async {
    try {
      final result = await platform
          .invokeMethod('getProducts', {'accessToken': accessToken});
      return NativeResponse(success: true, data: result);
    } on PlatformException catch (e) {
      return NativeResponse(success: false, message: e.message);
    }
  }

  static Future<NativeResponse> login(String username, String password) async {
    try {
      final result = await platform.invokeMethod('login', {
        'username': username,
        'password': password,
      });
      return NativeResponse(success: true, data: result);
    } on PlatformException catch (e) {
      return NativeResponse(success: false, message: e.message);
    }
  }
}
