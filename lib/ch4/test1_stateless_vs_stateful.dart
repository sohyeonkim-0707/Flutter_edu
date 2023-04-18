import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Test'),
        ),
        body: Center(
          child: Column(
            children: [
              MyStatelessWidget(),
              MyStatefulWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyStatelessWidget extends StatelessWidget {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    print('toggleFavorite....');
    if(favorited){
      favoriteCount--;
      favorited = false;
    }else {
      favoriteCount++;
      favorited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('stateless build....');
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.red,
        ),
        Container(
          child: Text('$favoriteCount'),
        ),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  //State 객체를 결정하기 위해서 자동 호출...
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}
class MyState extends State<MyStatefulWidget>{
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    print('toggleFavorite....');
    //state 의 데이터(상태) 값을 변경하고 그 변경이 화면에 적용되게 하려면 setState() 호출
    setState(() {
      if(favorited){
        favoriteCount--;
        favorited = false;
      }else {
        favoriteCount++;
        favorited = true;
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    print('stateful build....');
    return Row(
      children: [
        IconButton(
          onPressed: toggleFavorite,
          icon: (favorited ? Icon(Icons.star) : Icon(Icons.star_border)),
          color: Colors.red,
        ),
        Container(
          child: Text('$favoriteCount'),
        ),
      ],
    );
  }
}