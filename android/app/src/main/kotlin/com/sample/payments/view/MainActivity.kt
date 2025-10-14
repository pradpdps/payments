package com.sample.payments.view

import com.sample.payments.controller.MainController
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity(){
    val mainController: MainController by lazy {
        MainController(this@MainActivity)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (call.method == "getProducts") {
                    mainController.getProducts(result)
                } else {
                    result.notImplemented()
                }
            }
    }

    companion object {
        const val CHANNEL: String = "com.example.myapp/native"
    }
}