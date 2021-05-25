import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'main.dart';

void main() {
  runApp(myApp1());
}

class myApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: content(),
      ),
      title: "test",
    );
  }
}

class content extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homestate();
  }
}

class homestate extends State<content> {
  static const MethodChannel event =
      MethodChannel('samples.flutter.io/receive');

  @override
  void initState() {
    super.initState();
    event.setMethodCallHandler((call) async {
      print(call.arguments);
    });
  }

  void _onEvent(Object event) {
    print("onEvent: $event");
  }

  void _onError(Object error) {
    print("onError: $error");
  }

  static const MethodChannel methodChannel =
      MethodChannel('samples.flutter.io/battery');
  String _batteryLevel = 'Battery level: unknown.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await methodChannel.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level: $result%.';
    } on PlatformException {
      batteryLevel = 'Failed to get battery level.';
    }
    print(batteryLevel);
    // Fluttertoast.showToast(msg: batteryLevel);
  }

  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(dataURL);
    print(json.decode(response.body));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = new Container(
        padding: new EdgeInsets.all(20),
        child: new Column(
          children: [
            new GestureDetector(
              child: new Image.network(
                "https://camo.githubusercontent.com/3dd613452440147460261fa49bb4da59587bf977c1927d1d319c24ebbe712450/687474703a2f2f696d672e626c6f672e6373646e2e6e65742f32303137303732363133333431383134333f77617465726d61726b2f322f746578742f6148523063446f764c324a736232637559334e6b626935755a585176635846664d5455314d6a63334d446b3d2f666f6e742f3561364c354c32542f666f6e7473697a652f3430302f66696c6c2f49304a42516b46434d413d3d2f646973736f6c76652f37302f677261766974792f536f75746845617374",
                height: 240.0,
                fit: BoxFit.cover,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(builder: (context) => new MyApp2()),
                );
                // Fluttertoast.showToast(msg: "This is Center Short Toast");
              },
              onDoubleTap: () {
                _getBatteryLevel();
              },
            ),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: new Text(
                          'Oeschinen Lake Campground',
                          style: new TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      new Text(
                        'Kandersteg, Switzerland',
                        style: new TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                new Text("nihao"),
                new Icon(
                  Icons.star,
                  color: Colors.red[500],
                )
              ],
            ),
          ],
        ));

    return Scaffold(
        appBar: AppBar(
          title: Text("route"),
        ),
        body: content);
  }
}
