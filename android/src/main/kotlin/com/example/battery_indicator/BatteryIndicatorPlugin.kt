package com.example.battery_indicator

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** BatteryIndicatorPlugin */
class BatteryIndicatorPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    private lateinit var channel: MethodChannel
    private lateinit var binding: ActivityPluginBinding

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "battery_indicator")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "get_battery_indicator") {
            val  batteryLevel : Double = getBatteryIndicatorLevel()
            result.success(batteryLevel)
        } else {
            result.notImplemented()
        }
    }

    /// примеры реализации работы с батареей
    /// https://www.youtube.com/watch?v=1Y44e6Lz640
    /// https://www.youtube.com/watch?v=IekM_vjIiL0
    /// https://stackoverflow.com/questions/3291655/get-battery-level-and-state-in-android

    private var batteryBroadcastReceiver: BroadcastReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            val batteryLevel: Double = getBatteryIndicatorLevel()
            channel.invokeMethod("change_battery_indicator", batteryLevel)
        }
    }


    /// текущий заряд батареи
    private fun getBatteryIndicatorLevel(): Double {
        val iFilter = IntentFilter(Intent.ACTION_BATTERY_CHANGED)
        val batteryStatus: Intent? =
            binding.activity.applicationContext.registerReceiver(null, iFilter)

        // целое число, текущий уровень заряда
        val level: Int? = batteryStatus?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1)

        // целое число, содержащее максимальный уровень заряда батареи
        val scale: Int? = batteryStatus?.getIntExtra(BatteryManager.EXTRA_SCALE, -1)

        if (level != null && level > 0 && scale != null && scale > 0) {
            val batteryPct = level.toDouble() / scale.toDouble()
            return (batteryPct * 100)
//            return (batteryPct * 100).toInt()
        }

        return 0.0
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        this.binding = binding

        binding.activity.registerReceiver(this.batteryBroadcastReceiver,
            IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    }

    override fun onDetachedFromActivityForConfigChanges() {
        TODO("Not yet implemented")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromActivity() {
        TODO("Not yet implemented")
    }
}
