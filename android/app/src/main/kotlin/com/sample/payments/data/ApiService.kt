package com.sample.payments.data

import okhttp3.RequestBody
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.HeaderMap
import retrofit2.http.POST

/**
 * Defines the Retrofit API service interface for network requests.
 * Provides a method to fetch data from the specified endpoints.
 */
interface ApiService {


    /**
     * Makes a GET request to the endpoint "c/73e1-ef75-48bc-9f40".
     * @return Response containing the products as a String.
     */
    @GET("api/products")
    suspend fun getProducts(@HeaderMap headers: Map<String, String>): Response<String>

    @POST("api/auth/login")
    suspend fun loginUser(@Body data: RequestBody): Response<String>

}