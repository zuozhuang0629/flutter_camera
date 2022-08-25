package com.example.flutter_camera.network

import okhttp3.OkHttpClient
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

const val BASE_URL = "https://okkau.fun/"

object RetrofitUtils {

    fun createRetrofit(): NetApis {
        return Retrofit
            .Builder()
            .client(cameraOkHttp())
            .addConverterFactory(GsonConverterFactory.create())
            .baseUrl(BASE_URL)
            .build()
            .create(NetApis::class.java)
    }

    private fun cameraOkHttp(): OkHttpClient {
        val builder = OkHttpClient.Builder()

        return builder
            .readTimeout(20000, TimeUnit.MILLISECONDS)
            .writeTimeout(20000, TimeUnit.MILLISECONDS)
            .connectTimeout(20000, TimeUnit.MILLISECONDS)
            .build()
    }

}