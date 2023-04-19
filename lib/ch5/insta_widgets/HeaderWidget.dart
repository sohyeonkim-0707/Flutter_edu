import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const List<String> _choice = [
  '신고',
  '링크 복사',
  '공유하기'
];

class HeaderWidget extends StatelessWidget {
  //popup menu 클릭 이벤트 콜백함수..
  void _select(String choice){
    Fluttertoast.showToast(
        msg: choice,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('images/lab_instagram_icon_0.jpg'),
        Container(
          padding: EdgeInsets.only(left: 16),
          child: Text('instagram', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        ),
        Spacer(),
        PopupMenuButton(
            onSelected: _select,//메뉴 선택 이벤트
            itemBuilder: (BuildContext context){
              //팝업 메뉴 구성하기 위해서 자동 호출.. 이곳에서 리턴한 것으로 메뉴 구성..
              return _choice.map<PopupMenuItem<String>>((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            }
        ),
      ],
    );
  }
}