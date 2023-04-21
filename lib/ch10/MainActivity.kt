package com.example.flutter_lab

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        //message channel.....................
        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor, "myMessageChannel",
                            StringCodec.INSTANCE)
        channel.setMessageHandler{ message, reply ->
            Log.d("msg", "receive:$message")
            reply.reply("reply from Android")
            channel.send("Hello, i am platorm message"){ reply ->
                Log.d("msg", "reply:$reply")
            }
        }

        //method channel...........
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "myMethodChannel")
                .setMethodCallHandler { call, result ->
                    if(call.method == "parameterMap"){
                        val map = call.arguments as Map<String, String>
                        Log.d("msg", "${map.get("username")}, ${map.get("password")}")
                        result.success(mapOf("one" to "hello", "two" to "world"))
                    }else {
                        result.notImplemented()
                    }
                }
    }
}
