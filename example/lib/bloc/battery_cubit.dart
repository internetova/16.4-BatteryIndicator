import 'package:battery_indicator/battery_indicator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'battery_state.dart';

/// кубит для уровня заряда батареи
class BatteryCubit extends Cubit<BatteryState> {
  BatteryCubit() : super(BatteryState());

  late BatteryIndicator batteryIndicator;

  void getBatteryLevel() {
    batteryIndicator = BatteryIndicator(_onBattaryPowerChandeg);

  }

  void _onBattaryPowerChandeg(double value) {

    if (state.isFirstStart) {
      emit(BatteryState(currentLevel: value, previousLevel: value, isFirstStart: false));
    } else {
      emit(state.copyWith(currentLevel: value, previousLevel: state.currentLevel));
    }
  }
}
