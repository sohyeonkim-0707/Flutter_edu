import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Channel',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativeCallWidget(),
    );
  }
}

class NativeCallWidget extends StatefulWidget {
  @override
  NativeCallWidgetState createState() => NativeCallWidgetState();
}

class NativeCallWidgetState extends State<NativeCallWidget> {

  //message channel...........
  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCallMessageChannel() async {
    //channel 생성..
    var channel = BasicMessageChannel<String>('myMessageChannel', StringCodec());
    String? result = await channel.send('Hello, i am flutter message');
    print('reply : $result');
    setState(() {
      resultMessage = result;
    });
    //platform -> dart
    channel.setMessageHandler((message) async{
      setState(() {
        receiveMessage = message;
      });
      return 'Hi from Dart';
    });
  }

  //method channel......................
  String? resultMethod;
  Future<Null> nativeCallWithMethodChannel() async {
    var methodChannel = MethodChannel('myMethodChannel');
    try {
      var details = {"username":"kkang", "password":"1234"};
      Map result = await methodChannel.invokeMethod("parameterMap", details);
      setState(() {
        resultMethod = "${result['one']}, ${result['two']}";
      });
    }on PlatformException catch(e){
      print('exception : ${e.message}');
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Channel Test")),
        body: Center(
          child: Column(
            children: (<Widget>[
              Text('resultMessage:$resultMessage'),
              Text('receiveMessage:$receiveMessage'),
              ElevatedButton(
                  onPressed: nativeCallMessageChannel,
                  child: Text('message channel')
              ),
              Text('resultMethod: $resultMethod'),
              ElevatedButton(
                  onPressed: nativeCallWithMethodChannel,
                  child: Text('method channel')
              ),
            ]),
          ),
        )
    );
  }
}
