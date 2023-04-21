import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {

  String? latitude;
  String? longitude;

  getData() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location disabled');
    }
    //퍼미션이 필요한 기능들.. 그냥 실행하면 에러..
    //유저에 의해 거부가 될 수 있다..
    //현재 AndroidManifest.xml 에 등록한 퍼미션이 유저에 의해 허락된 것인지에 판다..
    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      //유저에게 퍼미션 조정 다이얼로그 띄워준다..
      //다이얼로그에 거부버튼도 있다. .결과 판단해야..
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission denied...');
      }
    }
    //위치 획득..
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      latitude = position.latitude.toString();
      longitude = position.longitude.toString();
    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Native Plugin")),
        body: Center(
          child: Column(
            children: (<Widget>[
              Text('latitude : $latitude'),
              Text('longitude: $longitude')
            ]),
          ),
        )
    );
  }
}
