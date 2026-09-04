package com.advick.ifarmconnect

import android.content.Intent
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    companion object {
        private const val appLifecycleChannel = "krishi_mart/app_lifecycle"
    }

    private var lifecycleChannel: MethodChannel? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        lifecycleChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            appLifecycleChannel,
        ).apply {
            setMethodCallHandler { call, result ->
                when (call.method) {
                    "wasOpenedFromLauncher" -> result.success(isLauncherIntent(intent))
                    else -> result.notImplemented()
                }
            }
        }
    }

    override fun onNewIntent(newIntent: Intent) {
        super.onNewIntent(newIntent)
        intent = newIntent
        lifecycleChannel?.invokeMethod(
            "launchSourceChanged",
            mapOf("openedFromLauncher" to isLauncherIntent(newIntent)),
        )
    }

    private fun isLauncherIntent(launchIntent: Intent?): Boolean =
        launchIntent?.action == Intent.ACTION_MAIN &&
            launchIntent.hasCategory(Intent.CATEGORY_LAUNCHER)
}
