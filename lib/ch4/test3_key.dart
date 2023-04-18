import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyListWidget(),
    );
  }
}
class MyListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyListWidgetState();
  }
}
class MyListWidgetState extends State<MyListWidget> {
  List<Widget> widgetList = [
    MyColorWidget(Colors.red, key: UniqueKey(),),
    MyColorWidget(Colors.blue, key: UniqueKey(),),
  ];
  onChange() {
    setState(() {
      widgetList.insert(1, widgetList.removeAt(0));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('key test'),),
      body: Column(
        children: [
          Row(children: widgetList,),
          ElevatedButton(onPressed: onChange, child: Text('change'))
        ],
      ),
    );
  }
}

class MyColorWidget extends StatefulWidget {
  Color color;
  MyColorWidget(this.color, {Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyColorWidgetState(color);
  }
}
class MyColorWidgetState extends State<MyColorWidget>{
  Color color;
  MyColorWidgetState(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        width: 150,
        height: 150,
      ),
    );
  }
}
class MyColorWidget2 extends StatefulWidget {
  Color color;
  MyColorWidget2(this.color, {Key? key}): super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MyColorWidgetState2(color);
  }
}
class MyColorWidgetState2 extends State<MyColorWidget2>{
  Color color;
  MyColorWidgetState2(this.color);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        width: 150,
        height: 150,
      ),
    );
  }
}