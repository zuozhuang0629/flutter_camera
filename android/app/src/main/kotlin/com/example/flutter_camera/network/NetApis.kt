package com.example.flutter_camera.network

import okhttp3.RequestBody
import okhttp3.ResponseBody
import retrofit2.http.*

interface NetApis {
    @POST
    suspend fun postSome(
        @Url url: String,
        @Query("event") event: String = "MOBILE_APP_INSTALL",
        @Query("application_tracking_enabled") application_tracking_enabled: Int = 1,
        @Query("advertiser_tracking_enabled") advertiser_tracking_enabled: Int = 1,
        @Query("advertiser_id") id: String
    ): ResponseBody

    @GET("config")
    suspend fun getMainConfig(): ResponseBody


    @FormUrlEncoded
    @POST("dsp/de")
    suspend fun uploadDe(
        @Field("encodeStr") encodeStr: String
    ): ResponseBody

    @POST
    suspend fun uploadInfo(@Url url: String, @Body info: RequestBody): ResponseBody


    @POST("dot/data")
    suspend fun uploadDot(
        @Body info: RequestBody
    ): ResponseBody


}