package com.example.ffi_right_way

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "ffi_the_right_way"
        ).setMethodCallHandler { call, result ->
            if (call.method == "add") {
                val firstInput = call.argument<Double>("input1")
                val secondInput = call.argument<Double>("input2")

                result.success(addNumbers(firstInput!!, secondInput!!))
            } else {
                result.notImplemented()
            }
        }
    }

    private fun addNumbers(firstInput: Double, secondInput: Double): Double {
        return firstInput + secondInput
    }
}
