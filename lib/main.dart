import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _batteryPercentage = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text(
          _batteryPercentage,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getBatteryInformation,
        child: const Icon(Icons.send_to_mobile),
      ),
    );
  }

  static const batteryChannel = MethodChannel('battery');
  Future<void> _getBatteryInformation() async {
    String batteryPercentage;
    try {
      var result =  await batteryChannel.invokeMethod('getBatteryLevel');
      batteryPercentage = 'Battery level at $result%';
    } on PlatformException catch (e) {
      batteryPercentage = "Failed to get battery level $e";
    }

    _batteryPercentage = batteryPercentage;
    setState(() {});
  }

}
