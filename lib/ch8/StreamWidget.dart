import 'package:flutter/material.dart';
import 'dart:async';
import 'my_util.dart';

class StreamWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StreamWidgetState();
  }
}
class StreamWidgetState extends State<StreamWidget>{
  List<Article> list = [];
  StreamController<List<Article>> streamController = StreamController();

  void getData(int page) async {
    await getServerData(page.toString()).then((value) {
      streamController.add(value);
    });
  }
  //반복 실행을 위해서..
  int transform(int i){
    int page = ++i;
    getData(page);
    return i;
  }
  peridoicStream() async {
    Duration duration = Duration(seconds: 5);
    Stream<int> stream = Stream<int>.periodic(duration, transform);
    stream = stream.take(5);
    await for(int i in stream){
      print('...$i');
    }
  }

  @override
  void initState() {
    super.initState();
    peridoicStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: streamController.stream,
        builder: (context, snapshot){
          if(snapshot.hasData){
            list.addAll(snapshot.data ?? []);
            return getWidget(list);
          }else if(snapshot.hasError){
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        }
    );
  }
}