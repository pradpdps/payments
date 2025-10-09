import 'package:flutter/services.dart';
import 'dart:developer';
import '../model/NativeResponse.dart';

class NativeService{
  static final platform = MethodChannel('com.example.myapp/native');

  static Future<NativeResponse> getProducts() async {
    try {
      final result = await platform.invokeMethod('getProducts');
      return NativeResponse(success: true, data: result);

    } on PlatformException catch (e) {
      return NativeResponse(success: false, message: e.message);
    }
  }
}