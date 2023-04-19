import 'package:flutter/material.dart';
import 'dart:convert';//json...
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AssetsBasicWidget extends StatelessWidget {
  //문자열 파일 로딩...
  Widget makeTextAssetWidget(context) {
    //파일 로딩이다.. 시간이 걸릴 수 있다.. 미래에 발생하는 데이터.. Future...
    //Future 를 이용해 화면 구성하는 위젯이 FutureBuilder 이다..
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/my_text.txt'),
        //future 에 의해 발생하는 데이터로 화면 구성하기 위해서 호출..
        //두번재 매개변수에 전달..
        builder: (context, snapshot){
          if(snapshot.hasData){
            return Text(
              'text assets : ${snapshot.data}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.red,
                  fontSize: 20,
                  backgroundColor: Colors.yellow,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.red,
                  decorationStyle: TextDecorationStyle.wavy
              ),
              maxLines: 2,
              overflow: TextOverflow.fade,
            );
          }
          //데이터가 없다면..
          return Text('');
        }
    );
  }

  Widget makeJsonWidget(context){
    return FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/text/data.json'),
        builder: (context, snapshot){
          if(snapshot.hasData){
            //json 파싱.. Map 객체로..
            var root = json.decode(snapshot.data.toString());
            return Text('${root[0]['name']} - ${root[0]['age']}');
          }
          return Text('');
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage('assets/icon/user.png'),
          ),
          Image.asset('assets/icon/user.png'),
          makeTextAssetWidget(context),
          makeJsonWidget(context),
          Icon(Icons.menu),
          Icon(FontAwesomeIcons.music, size: 30, color: Colors.pink,)
        ],
      ),
    );
  }
}