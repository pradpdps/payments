package com.sample.payments.controller

import android.util.Log
import androidx.lifecycle.lifecycleScope
import com.sample.payments.data.ApiService
import com.sample.payments.utils.NetworkHelper
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.scalars.ScalarsConverterFactory
import kotlin.coroutines.cancellation.CancellationException

// Controller class to handle native method calls from Flutter
class MainController(val activity: FlutterActivity) {

    private val networkHelper by lazy {
        NetworkHelper(activity.applicationContext)
    }
    private val retrofit by lazy {
        Retrofit.Builder()
            .baseUrl("https://dummyjson.com/") // Replace with your API base URL
            .addConverterFactory(ScalarsConverterFactory.create())
            .build()
    }
    private val api: ApiService by lazy {
        retrofit.create(ApiService::class.java)
    }


    /**
     * Handles the "getProducts" method call from Flutter.
     * Makes a GET request to the endpoint "products".
     * @param result MethodChannel.Result to send the response back to Flutter.
     * @return Sends the products as a String on success, or an error on failure.
     */
    fun getProducts(result: MethodChannel.Result){
        // Launch a coroutine on the IO dispatcher for background work
        activity.lifecycleScope.launch(Dispatchers.IO + exceptionHandler(result)) {
            if (networkHelper.isInternetAvailable()){
                val productResponse = api.getProducts()
                if(productResponse.isSuccessful){
                    result.success(productResponse.body())
                }else{
                    result.error("${productResponse.code()}",productResponse.message(),productResponse.errorBody()?.string())
                }
            }else {
                result.error("500","No Internet Connection","Please check your internet connection and try again.")
            }
        }
    }

    // Creates a CoroutineExceptionHandler that logs errors and sends them back to Flutter
    private fun exceptionHandler(result: MethodChannel.Result): CoroutineExceptionHandler {
        return CoroutineExceptionHandler { _, exception ->
            if(exception !is CancellationException){
                Log.e("API ERROR", exception.message.toString())
                result.error("500", exception.message.toString(), exception.message.toString())
            }
        }
    }
}