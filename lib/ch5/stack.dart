import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';


class DataVO {
  String image;
  String title;
  String date;
  String content;
  String location;
  DataVO(this.image, this.title, this.date, this.content, this.location);
}
List<DataVO> datas = [
  DataVO('images/lab_lotte_1.jpg', '롯데웨딩위크', '각 지점 본 매장', '2.14(금) ~ 2.23(일)',
      '백화점 전점'),
  DataVO('images/lab_lotte_2.jpg', 'LG TROMM 스타일러', '각 지점 본 매장',
      '2.14(금) ~ 2.29(토)', '백화점 전점'),
  DataVO(
      'images/lab_lotte_3.jpg', '금양와인 페스티발', '본매장', '2.15(토) ~ 2.20(목)', '잠실점'),
  DataVO('images/lab_lotte_4.jpg', '써스데이 아일랜드', '본 매장', '2.17(월) ~ 2.23(일)',
      '잠실점'),
  DataVO('images/lab_lotte_5.jpg', '듀풍클래식', '본 매장', '2.21(금) ~ 3.8(일)', '잠실점'),
];

//card 한장을 표현하는 위젯..
class CardADWidget extends StatelessWidget {
  DataVO vo;
  CardADWidget(this.vo);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.pink,
        ),
        Align(
          alignment: Alignment(0.0, 0.0),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(vo.image, width: 350),
                  Container(
                    width: 350,
                    height: 100,
                    color: Colors.white,
                    padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(vo.title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        Spacer(),
                        Text(vo.content),
                        Text(vo.date),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                  left: 30,
                  bottom: 90,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.black,
                    child: Text(vo.location, style: TextStyle(color: Colors.white),),
                  )
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyWidgetState();
  }
}
class MyWidgetState extends State<MyWidget> {
  //데이터 갯수 만큼 화면 위젯을 만드는 개발자 함수..
  List<CardADWidget> makeViewPagerWidgets() {
    return datas.map((vo){
      return CardADWidget(vo);
    }).toList();
  }
  //viewpager 제어...
  PageController controller = PageController(
    initialPage: 0,//초기에 뿌리는 화면..
    viewportFraction: 0.9,//현재 나와있는 화면을 기준으로 왼쪽, 오른쪽 화면이 어느정도 보여야 하는지...
    //1.0 으로 지정하면 현재 화면만 보인다..
  );

  @override
  Widget build(BuildContext context) {
    return PageIndicatorContainer(//viewpager 하단에.. indicator 추가..
      child: PageView(
        controller: controller,
        children: makeViewPagerWidgets(),
      ),
      indicatorColor: Colors.white,
      indicatorSelectorColor: Colors.blue,
      length: datas.length,
      shape: IndicatorShape.roundRectangleShape(size: Size(20, 3)),
      indicatorSpace: 1,//indicator 간의 간격..
    );
  }
}


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Test'),
        ),
        body: SafeArea(//화면이 기기에 영향을 받지 않게 알아서 조정해 준다.. 라운드 사각형.. 노치..
          child: Container(
            color: Colors.pink,
            child: MyWidget(),
          ),
        ),
      ),
    );
  }
}