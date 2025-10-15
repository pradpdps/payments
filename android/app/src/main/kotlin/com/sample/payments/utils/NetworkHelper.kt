package com.sample.payments.utils

import android.content.Context
import android.net.ConnectivityManager
import android.net.NetworkCapabilities

class NetworkHelper(private val context: Context) {

    /**
     * Checks if the internet is available via WiFi, Mobile Data, or Ethernet.
     * @return true if internet is available through one of the specified transports, false otherwise.
     */
    fun isInternetAvailable(): Boolean {
        // Get the ConnectivityManager from the system service
        val connectivityManager = context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        // Get the currently active network, return false if none
        val network = connectivityManager.activeNetwork ?: return false

        // Get the capabilities of the active network, return false if not available
        val networkCapabilities = connectivityManager.getNetworkCapabilities(network) ?: return false

        // Check if the network has internet capability and is of type WiFi, Cellular, or Ethernet
        return when {
            networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) ->
                networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) ->
                networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            networkCapabilities.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) ->
                networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            else -> false
        }
    }
}