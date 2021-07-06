part of 'battery_cubit.dart';

/// состояние батареи
/// [currentLevel] - текущий уровень заряда
@immutable
class BatteryState {
  final double currentLevel;
  final double previousLevel;
  final bool isFirstStart;

  BatteryState({
    this.currentLevel = 100,
    this.previousLevel = 100,
    this.isFirstStart = true,
  });

  BatteryState copyWith({
    double? currentLevel,
    double? previousLevel,
    bool? isFirstStart,
}) {
    return BatteryState(
      currentLevel: currentLevel ?? this.currentLevel,
      previousLevel: previousLevel ?? this.previousLevel,
      isFirstStart: isFirstStart ?? this.isFirstStart,
    );
  }
}
