package com.brian.media_meta_plus
import android.util.Log
import android.os.Build
import android.os.Handler
import android.os.Looper
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.alexmercerind.flutter_media_metadata.MetadataRetriever

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.util.concurrent.CompletableFuture

/** MediaMetaPlusPlugin */
class MediaMetaPlusPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "media_meta_plus"
        )
        channel.setMethodCallHandler(this)
    }

    @RequiresApi(Build.VERSION_CODES.N)
    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        Log.d("MediaMetaPlusPlugin", "onMethodCall: ${call.method}")
        if (call.method == "fromFile") {
            try {
                CompletableFuture.runAsync(
                    Runnable {
                        val retriever = MetadataRetriever()
                        retriever.setFilePath(call.argument("filePath"))
                        val response = HashMap<String, Any?>()
                        response["metadata"] = retriever.metadata
                        response["albumArt"] = retriever.albumArt
                        retriever.release()
                        Handler(Looper.getMainLooper())
                            .post { result.success(response) }
                    },
                )
            }
            catch (e){
                Log.e("MediaMetaPlusPlugin", "Error: ${e.message}")
            }

        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
