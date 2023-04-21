import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

void main() {
  runApp(SampleApp());
}

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IsolateScreen(),
    );
  }
}

class IsolateScreen extends StatefulWidget {
  @override
  IsolateScreenState createState() => IsolateScreenState();
}

class IsolateScreenState extends State<IsolateScreen> {

  //ListView 에 페이징 개념 도입..
  //스크롤 정보를 활용해서 마지막을 판단 자동으로 다음 데이터 획득 추가..
  //ListView 의 스크롤 정보를 받을 Controller 필요...
  ScrollController controller = ScrollController();

  //isolate 에서 받는 데이터.. 서버 데이터...
  List datas = [];
  //서버 요청 정보.. isolate 에 전달할 데이터..
  int page = 1;
  int seed = 1;

  //isolate 에 의해 실행될 함수...
  static dataLoader(SendPort sendPort) async {
    ReceivePort port = ReceivePort();
    sendPort.send(port.sendPort);//main 의 데이터를 받기 위해서...

    await for(var msg in port){
      String url = msg[0];
      SendPort replyTo = msg[1];

      //네트웍 시도..
      http.Response response = await http.get(Uri.parse(url));
      replyTo.send(json.decode(response.body));
    }
  }

  //main 에서 실행...
  //서버 연동이 필요할 때마다 호출... 서버연동을 위한 데이터 준비해서 isolate 구동...
  Future<List> getServerData() async {
    String url = 'https://randomuser.me/api/?seed=${seed}&page=${page}&results=20';
    print(url);
    ReceivePort receivePort = ReceivePort();
    Isolate.spawn(dataLoader, receivePort.sendPort);
    SendPort sendPort = await receivePort.first;

    ReceivePort response = ReceivePort();
    sendPort.send([url, response.sendPort]);
    Map<String, dynamic> result = await response.first;
    return result['results'];
  }

  @override
  void initState() {
    super.initState();
    //스크롤 이벤트 등록..
    controller.addListener(scrollListener);
    //초기 데이터 획득..
    getServerData().then((result){
      setState(() {
        datas = result;
      });
    });
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  //화면 갱신시 호출될 함수..
  Future<List<dynamic>> refresh() async {
    page = 1;
    seed++;
    List result = await getServerData();
    setState(() {
      datas = result;
    });
    return result;
  }
  //scroll 이벤트 처리 함수..
  scrollListener() async {
    //스크롤이 마지막까지 되었는지에 대한 판단..
    if(controller.offset >= controller.position.maxScrollExtent && !controller.position.outOfRange){
      page++;
      List result = await getServerData();
      setState(() {
        datas.addAll(result);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Isolate Example'),
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int position){
              return ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text("${datas[position]['name']['first']} ${datas[position]['name']['last']}"),
                subtitle: Text(datas[position]['email']),
                leading: CircleAvatar(
                  radius: 25,
                  child: ClipOval(
                    child: Image.network(datas[position]['picture']['thumbnail']),
                  )
                  ,
                ),
              );
            },
            separatorBuilder: (BuildContext context, int position){
              return Divider(
                color: Colors.black,
              );
            },
            itemCount: datas.length,
            controller: controller,
          ),
        )
    );
  }
}