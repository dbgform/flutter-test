//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:myapp/state.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StateManager(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter(BuildContext context) {
    Provider.of<StateManager>(context, listen: false).incCounter();
    var a = 10.toDouble();
  }

  static const platform = MethodChannel('samples.flutter.dev/battery');
  //String _batteryLevel = 'Unknown battery level.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Consumer<StateManager>(
              builder: (context, state, child) {
                var counter = state.counter;

                return Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            TextButton(
              onPressed: () {
                Provider.of<StateManager>(context, listen: false).getWord();
              },
              child: Text('click me'),
            ),
            Consumer<StateManager>(
              builder: (context, state, child) {
                var word = state.word;
                return SelectableText(
                  '$word',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ElevatedButton(
              child: Text('Get Battery Level'),
              onPressed: () {
                Provider.of<StateManager>(context, listen: false)
                    .getBatteryLevel();
              },
            ),
            Consumer<StateManager>(
              builder: (context, state, child) {
                var batteryLvl = state.batteryLevel;

                return Text(
                  '$batteryLvl',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _incrementCounter(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
