package com.example.flutter_camera

import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.os.StrictMode
import android.util.Base64
import android.util.Log
import com.facebook.FacebookSdk
import com.facebook.appevents.AppEventsLogger
import com.facebook.applinks.AppLinkData
import com.google.android.gms.ads.identifier.AdvertisingIdClient
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import okhttp3.MediaType
import okhttp3.RequestBody
import java.io.ByteArrayOutputStream
import java.security.KeyFactory
import java.security.spec.X509EncodedKeySpec
import javax.crypto.Cipher
import kotlin.concurrent.thread


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(PlatformViewPlugin())
    }

    private val TAG = "FlutterActivity"
    private val channel = "toJava"
    private val channeFacebook = "initfacebook"
    private val channeDeeplink = "listenerDeeplinks"
    private val gaid1 = "initGaid"
    private val gaid2 = "getGaid"

    companion object {
        var gaidStr = ""

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (android.os.Build.VERSION.SDK_INT > 9) {
            val policy = StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(
                it,
                channel
            ).setMethodCallHandler { call, result ->
                Log.d(TAG, "onMethodCall: " + call.method)
                if (call.method != null) {
                    val jsonStr: String = call.argument("jsonStr") ?: ""
                    val encode: String = call.argument("encode") ?: ""
                    val padding: String = call.argument("padding") ?: ""
                    result.success(toJava(jsonStr, encode, padding));
                } else {
                    result.notImplemented();
                }

            }

            MethodChannel(
                it,
                channeFacebook
            ).setMethodCallHandler { call, result ->
                if (call.method != null) {
                    Log.d(TAG, "onMethodCall: " + call.method)
                    val id: String = call.argument("id") ?: ""

                    if (id.isNotEmpty()) {
                        FacebookSdk.setApplicationId(id)
                        FacebookSdk.sdkInitialize(this)
                        FacebookSdk.setAdvertiserIDCollectionEnabled(true)
                        FacebookSdk.setCodelessDebugLogEnabled(true)
                        FacebookSdk.setAutoLogAppEventsEnabled(true)
                        FacebookSdk.fullyInitialize()
                        result.success(FacebookSdk.isInitialized())
                    }


                } else {
                    result.notImplemented();
                }

            }

            MethodChannel(
                it,
                channeDeeplink
            ).setMethodCallHandler { call, result ->
                if (call.method != null) {
                    val id: String = call.argument("id") ?: ""
                    if (id.isNotEmpty()) {
                        startDeeplink(result)
                    }


                } else {
                    result.notImplemented();
                }

            }

            val methodChannel = MethodChannel(
                it,
                gaid1
            )

            methodChannel.setMethodCallHandler { call, result ->
                thread {
                    getGaid()

                }.start()

            }

            MethodChannel(
                it,
                gaid2
            ).setMethodCallHandler { call, result ->
                result.success(gaidStr)


            }


        }
    }

    fun getGaid() {


        var adInfo: AdvertisingIdClient.Info? = null
        try {
            adInfo = AdvertisingIdClient.getAdvertisingIdInfo(this)
        } catch (e: Exception) {
            Log.e("gaid", "Exception:$e")
        }
        if (adInfo != null) {
            gaidStr = adInfo.id.toString()
            Log.e("gaid", "gaid:$gaidStr")

        }
    }


    fun startDeeplink(result: MethodChannel.Result) {
        AppLinkData.fetchDeferredAppLinkData(context, object : AppLinkData.CompletionHandler {
            override fun onDeferredAppLinkDataFetched(appLinkData: AppLinkData?) {
                result.success(appLinkData != null)
            }
        })
    }

    fun toJava(str: String, encoencodede: String, p: String): String? {
        return decodeStr(str, encoencodede, p)
    }

    fun decodeStr(str: String, encoencodede: String, p: String): String {

        val cipher = Cipher.getInstance(p)

        val public = KeyFactory.getInstance("RSA").let {
            val x50 = X509EncodedKeySpec(
                Base64.decode(
                    encoencodede.toByteArray(charset("UTF-8")),
                    Base64.DEFAULT
                )
            )
            it.generatePublic(x50)
        }


        cipher.init(Cipher.ENCRYPT_MODE, public)
        val bytesArray = str.toByteArray()

        val max = bytesArray.size / cipher.getOutputSize(bytesArray.size)

        var blockCount = bytesArray.size / max
        if (bytesArray.size % blockCount != 0) {
            blockCount += 1
        }

        val baos = ByteArrayOutputStream(blockCount * max)
        var offset = 0
        var isCountim = true

        while (isCountim) {
            isCountim = offset < bytesArray.size
            if (isCountim) {
                val fd = bytesArray.size
                var encryptedBlock: ByteArray? = ByteArray(0)
                try {
                    var il = fd - offset
                    if (il > max) {
                        il = max
                    }
                    encryptedBlock = cipher!!.doFinal(bytesArray, offset, il)
                    baos.write(encryptedBlock)
                    offset += max
                } catch (e: java.lang.Exception) {
                    e.printStackTrace()
                    break
                }
            }
        }
        baos?.close()

        return Base64.encodeToString(baos?.toByteArray(), Base64.NO_WRAP)
    }


}
