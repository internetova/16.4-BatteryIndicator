part of 'battery_cubit.dart';

/// состояние батареи
/// [currentLevel] - текущий уровень заряда
@immutable
class BatteryState {
  final double currentLevel;

  BatteryState({
    this.currentLevel = 100,
  });
}
