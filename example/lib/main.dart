import 'package:flutter/material.dart';
import 'package:battery_indicator/battery_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _currentBatteryIndicatorLevel = 0.0;
  late BatteryIndicator batteryIndicator;

  @override
  void initState() {
    super.initState();
    batteryIndicator = BatteryIndicator(_onBattaryPowerChandeg);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(
            '$_currentBatteryIndicatorLevel %',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          /// текущий уровень заряда батареи
          onPressed: () => batteryIndicator.getBatteryIndicatorLevel(),
          child: Icon(Icons.battery_alert),
        ),
      ),
    );
  }

  void _onBattaryPowerChandeg(double value) {
    setState(() {
      _currentBatteryIndicatorLevel = value;
    });
  }
}
