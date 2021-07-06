import 'package:battery_indicator_example/bloc/battery_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// задание 16.4
/// Напишите плагин “Индикатор батареии”. Плагин должен считывать показания
/// датчиков батареи нативных платформ, передавать данные в flutter приложение.
/// Плагин должен иметь коллбэк onBattaryPowerChandeg(double value), который
/// оповещает об изменении заряда батареи и передает значение в процентах.
/// При уменьшении заряда показывать снек, с предупреждением.

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => BatteryCubit()..getBatteryLevel(),
        child: BatteryScreen(),
      ),
    );
  }
}

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: BlocConsumer<BatteryCubit, BatteryState>(
        listener: (_, state) {
          final snackBar = SnackBar(
            content: Text('Уровень заряда: ${state.currentLevel}'),
            backgroundColor: Theme.of(context).errorColor,
          );

          if (state.previousLevel > state.currentLevel) {
            if (state.currentLevel == 50 ||
                state.currentLevel == 40 ||
                state.currentLevel == 30 ||
                state.currentLevel == 20) {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }
        },
        builder: (context, state) {
          return Center(
            child: Text(
              'заряд  ${state.currentLevel.toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.headline4,
            ),
          );
        },
      ),
    );
  }
}
