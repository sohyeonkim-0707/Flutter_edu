


import 'package:flutter/material.dart';
import 'package:flutter_lab/ch6/widgets/assets_basic_widget.dart';
import 'package:flutter_lab/ch6/widgets/form_widget.dart';
import 'package:flutter_lab/ch6/widgets/input_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Test'),
        ),
        // body: AssetsBasicWidget(),
        // body: TextFieldWidget(),
        body: FormWidget(),
      ),
    );
  }
}
