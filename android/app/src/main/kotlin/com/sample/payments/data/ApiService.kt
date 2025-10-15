package com.sample.payments.data

import retrofit2.Response
import retrofit2.http.GET

/**
 * Defines the Retrofit API service interface for network requests.
 * Provides a method to fetch data from the specified endpoints.
 */
interface ApiService {


    /**
     * Makes a GET request to the endpoint "c/73e1-ef75-48bc-9f40".
     * @return Response containing the products as a String.
     */
    @GET("c/73e1-ef75-48bc-9f40")
    suspend fun getProducts(): Response<String>
}