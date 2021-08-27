import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StateManager extends ChangeNotifier {
  int _counter = 0;
  int get counter {
    return _counter;
  }

  String get batteryLevel {
    return _batteryLevel;
  }

  static const platform = MethodChannel('samples.flutter.dev/battery');
  String _batteryLevel = 'Unknown battery level.';

  String word = '';
  int _next = 0;

  batteryLvl(percents) {
    _batteryLevel = percents;
    notifyListeners();
  }

  incCounter() {
    _counter++;
    notifyListeners();
  }

  Future<void> getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
    _batteryLevel = batteryLevel;
    notifyListeners();
  }

  getWord() {
    List<String> arr = ['test', 'apple', 'phone'];
    word = arr[_next];
    _next++;
    if (_next >= arr.length) {
      _next = 0;
    }
    notifyListeners();
  }
}
