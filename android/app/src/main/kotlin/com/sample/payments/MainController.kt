package com.sample.payments

import androidx.lifecycle.lifecycleScope
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

class MainController(val activity: FlutterActivity) {
    fun getProducts(result: MethodChannel.Result){
        activity.lifecycleScope.launch(Dispatchers.IO) {
            delay(5000) //Simulate netword delay
            val response = "[{\"name\":\"Bass Boost Headphones\",\"price\":79.99,\"description\":\"Experience deep bass and crisp sound with these stylish headphones.\",\"image\":\"assets/h1.webp\"},{\"name\":\"Wireless Comfort Headphones\",\"price\":99.99,\"description\":\"Enjoy wireless freedom and all-day comfort with soft ear cushions.\",\"image\":\"assets/h2.webp\"},{\"name\":\"Studio Pro Headphones\",\"price\":149.99,\"description\":\"Perfect for studio recording and mixing, with premium sound quality.\",\"image\":\"assets/h3.jpg\"},{\"name\":\"Travel Lite Headphones\",\"price\":59.99,\"description\":\"Lightweight and foldable, ideal for travel and daily commutes.\",\"image\":\"assets/h1.webp\"},{\"name\":\"Gaming Surround Headphones\",\"price\":129.99,\"description\":\"Immersive surround sound for gaming and entertainment.\",\"image\":\"assets/h2.webp\"}]"
            result.success(response)
        }
    }
}