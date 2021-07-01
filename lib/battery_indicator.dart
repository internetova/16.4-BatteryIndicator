
import 'dart:async';

import 'package:flutter/services.dart';

/// задание 16.4
/// Напишите плагин “Индикатор батареии”. Плагин должен считывать показания
/// датчиков батареи нативных платформ, передавать данные в flutter приложение.
/// Плагин должен иметь коллбэк onBattaryPowerChandeg(double value), который
/// оповещает об изменении заряда батареи и передает значение в процентах.
/// При уменьшении заряда показывать снек, с предупреждением.
class BatteryIndicator {
  static const MethodChannel _channel =
      const MethodChannel('battery_indicator');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
