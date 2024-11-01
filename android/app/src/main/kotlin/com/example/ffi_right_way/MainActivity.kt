package com.example.ffi_right_way

import FfiTRWFlutterApi
import FfiTRWHostApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import java.util.Timer
import kotlin.concurrent.timer

class MainActivity : FlutterActivity(), FfiTRWHostApi {

    private var ffiTimer: Timer? = null
    private var flutterApi: FfiTRWFlutterApi? = null
    private var result: Long = 0

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        FfiTRWHostApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
        flutterApi = FfiTRWFlutterApi(flutterEngine.dartExecutor.binaryMessenger)
    }

    override fun add(a: Double, b: Double): Double {
        return a + b
    }

    override fun startTimer() {
        ffiTimer?.cancel()
        ffiTimer = timer(period = 2000L) {
            runOnUiThread {
                flutterApi?.onReceiveTimerResult(result) {
                    if (it.isSuccess) {
                        result += 1
                    }
                }
            }
        }
    }

    override fun stopTimer() {
        ffiTimer?.cancel()
        ffiTimer = null
        result = 0
    }
}
