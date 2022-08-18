package com.example.flutter_camera

import android.os.Bundle
import android.os.StrictMode
import android.util.Base64
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import java.io.ByteArrayOutputStream
import java.security.KeyFactory
import java.security.spec.X509EncodedKeySpec
import javax.crypto.Cipher


class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(PlatformViewPlugin())
    }

    private val channel = "toJava"
    private val channel2 = "httpJ"


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        if (android.os.Build.VERSION.SDK_INT > 9) {
            val policy = StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
        }

        flutterEngine?.dartExecutor?.getBinaryMessenger()?.let {
            MethodChannel(
                it,
                channel
            ).setMethodCallHandler { call, result ->
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
                channel2
            ).setMethodCallHandler { call, result ->
                if (call.method != null) {
                    val jsonStr: String = call.argument("jsonStr") ?: ""
                    val encode: String = call.argument("encode") ?: ""
                    val padding: String = call.argument("padding") ?: ""
                    result.success(toJava(jsonStr, encode, padding));
                } else {
                    result.notImplemented();
                }

            }
        }
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
