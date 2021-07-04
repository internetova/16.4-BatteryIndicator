import 'dart:async';

import 'package:flutter/services.dart';

/// задание 16.4
/// Напишите плагин “Индикатор батареии”. Плагин должен считывать показания
/// датчиков батареи нативных платформ, передавать данные в flutter приложение.
/// Плагин должен иметь коллбэк onBattaryPowerChandeg(double value), который
/// оповещает об изменении заряда батареи и передает значение в процентах.
/// При уменьшении заряда показывать снек, с предупреждением.

class BatteryIndicator {
  final void Function(double value) _onBattaryPowerChandeg;

  BatteryIndicator(this._onBattaryPowerChandeg) {
    _initBatteryIndicator();
  }

  static const String _getBatteryIndicatorMethod = 'get_battery_indicator';
  static const String _changeBatteryMethod = 'change_battery_indicator';

  static const MethodChannel _channel =
      const MethodChannel('battery_indicator');

  /// метод инициализации плагина при создании
  void _initBatteryIndicator() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case _changeBatteryMethod:
          _onBattaryPowerChandeg(call.arguments);
          break;
      }
    });
  }

  /// текущий уровень заряда батареи
  Future<double> getBatteryIndicatorLevel() async {
    return await _channel.invokeMethod(_getBatteryIndicatorMethod);
  }
}
