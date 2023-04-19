import 'package:flutter/material.dart';

class ContentWidget extends StatelessWidget {
  int count = 100;
  String id = "instagram";
  String content = "동해물과 백두산이 마르고 닳도록 하나님이 보우아사 우리나라 만세..........";
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('좋아요 $count 개'),
        Text.rich(//문자열 부분 부분을 다양하게 꾸미고자 할때..
            TextSpan(
                children: [
                  TextSpan(text: id, style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: content, style: TextStyle(fontSize: 40)),
                ]
            )
        )
      ],
    );
  }
}