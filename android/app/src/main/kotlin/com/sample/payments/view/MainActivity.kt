package com.sample.payments.view

import android.util.Log
import com.sample.payments.controller.MainController
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.KeyData.CHANNEL
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
                    val accessToken = call.argument<String>("accessToken").toString()
                    mainController.getProducts(accessToken, result)
                } else if (call.method == "login") {
                    val username = call.argument<String>("username").toString()
                    val password = call.argument<String>("password").toString()
                    mainController.login(username, password, result)
                } else {
                    result.notImplemented()
                }
            }
    }

    companion object {
        const val CHANNEL: String = "com.example.myapp/native"
    }
}