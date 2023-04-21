import 'package:flutter/material.dart';
//VO...
class Todo {
  String title;
  bool completed;

  //required... 필수 입력
  Todo({required this.title, this.completed = false});

  void toggleCompleted(){
    completed = !completed;
  }
}
