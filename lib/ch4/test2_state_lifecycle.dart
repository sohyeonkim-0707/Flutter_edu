import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(ParentWidget());

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ParentWidgetState();
  }
}
class ParentWidgetState extends State<ParentWidget> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lifecycle Test'),
        ),
        body: Provider.value(//하위에 상태 데이터 전파 역할을 한다..
          value: _counter,//하위 위젯에서 사용하고자 하는 데이터..
          child: Column(
            children: [
              Text('parent widget'),
              ChildWidget(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _incrementCounter,
        ),
      ),
    );
  }
}

class ChildWidget extends StatefulWidget {
  ChildWidget(){
    print('ChildWidget constructor....');
  }
  @override
  State<StatefulWidget> createState() {
    return ChildWidgetState();
  }
}
//WidgetsBindingObserver - app 의 resume, pause 등의 라이프사이클...
class ChildWidgetState extends State<ChildWidget> with WidgetsBindingObserver{
  int _counter = 0;//상위 위젯의 데이터를 받을 변수...
  ChildWidgetState(){
    print('ChildWidgetState constructor...');
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);//앱의 라이프사이클 핸들러 등록..
    print('ChildWidgetState..initState...');
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //상위의 상태값 변경을 획득..
    _counter = Provider.of<int>(context);
    print('ChildWidgetState..didChangeDependencies, counter = $_counter');
  }
  @override
  Widget build(BuildContext context) {
    print('ChildWidgetState..build');
    return Text(
      'ChildWidget : $_counter',
    );
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('didChangeAppLifecycleState... $state');
  }
}

//초기상태
//I/flutter (10268): ChildWidget constructor....
// I/flutter (10268): ChildWidgetState constructor...
// I/flutter (10268): ChildWidgetState..initState...
// I/flutter (10268): ChildWidgetState..didChangeDependencies, counter = 0
// I/flutter (10268): ChildWidgetState..build

//상위 상태 변경 시...
//I/flutter (10268): ChildWidget constructor....
// I/flutter (10268): ChildWidgetState..didChangeDependencies, counter = 2
// I/flutter (10268): ChildWidgetState..build