import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Test'),),
        body: MyInheritedWidget(TestScreen()),
      ),
    );
  }
}

//위젯이지만 화면을 목적으로 하지 않는다.. 하위 공통 상태 유지하기 위한 목적이다..
class MyInheritedWidget extends InheritedWidget {
  //상태값을 저장할 변수 선언...
  int count = 0;
  //자신의 하위에 포함될 위젯 선언..
  Widget child;
  MyInheritedWidget(this.child): super(child: child);
  //상태값을 하위헤서 변경하고자 할때 호출되는 함수..
  increment() {
    count++;
  }
  //자신이 리빌드 될때.. 하위도 리빌드 되어야 하는지를 판단하기 위해서 자동 호출..
  //true - 리빌드..
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
  //하위 어딘가에서 자신의 객체를 이용해서 상태를 얻거나 변경한다..
  //하위 생성자 매개변수를 통해 계속 전달하자는 구조가 아니니까..
  //객체를 얻기 위한 함수를 하나 정의해 준다..
  //일반적으로 of 함수를 이용하지만.. 함수명은 다른 것 가능..
  //이 클래스 내에 선언되어 있다면 static 으로.. 외부에 선언도 가능하고..
  static MyInheritedWidget? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
}

//상태 데이터가 발생하는 inherited 하위...
class TestScreen extends StatelessWidget {
  int myCounter = 0;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState){
          //inherited 객체 획득..
          MyInheritedWidget? widget = MyInheritedWidget.of(context);
          return Row(
            children: [
              Text('TestScreen'),
              Text('${widget?.count}'),
              ElevatedButton(
                  onPressed: (){
                    setState((){
                      widget?.increment();
                    });
                  },
                  child: Text('increment')
              ),
              TestScreenSub(),
            ],
          );
        }
    );
  }
}

class TestScreenSub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context)!.count;
    return Row(
      children: [
        Text('TestScreenSub : ${count}')
      ],
    );
  }
}