import 'package:flutter/material.dart';
import 'package:flutter_lab/ch5/insta_widgets/ContentWidget.dart';
import 'package:flutter_lab/ch5/insta_widgets/IconWidget.dart';
import 'package:flutter_lab/ch5/insta_widgets/ImageWidget.dart';
import 'insta_widgets/HeaderWidget.dart';
//개발자 dart 파일을 lib 폴더에 작성한다..
//dart 를 다른 폴더에 추가 안된다..
// import 'package:flutter_lab/ch5/insta_widgets/HeaderWidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: SingleChildScrollView(
            child: Column(
              children: [
                HeaderWidget(),
                ImageWidget(),
                IconWidget(),
                ContentWidget(),
              ],
            )
        ),

      ),
    );
  }
}
