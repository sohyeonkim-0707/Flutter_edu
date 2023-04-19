import 'package:flutter/material.dart';

//입력 데이터가 저장될 클래스...
class User {
  String? firstName;
  String? lastName;
}

class FormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormWidgetState();
  }
}
class FormWidgetState extends State<FormWidget> {
  //form 에 지정할 key...
  var formKey = GlobalKey<FormState>();
  var user = User();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
            validator: (value){
              //form 의 state 의 validate() 함수를 호출하면 form 하위의 입력 위젯의 validator 함수가 자동 호출..
              //매개변수가 현재 유저가 입력한 값..
              //null 이 리턴되면 유효하다.. 즉 에러메시지 없다..
              //문자열 리턴.. invalid... 에러메시지..
              if(value?.isEmpty ?? false){
                return 'enter your first name';
              }
              return null;
            },
            onSaved: (value){
              //form 의 state 의 save() 함수 호출하는 순간 자동 호출.. 매개변수는 입력값..
              user.firstName = value;
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
            validator: (value){
              //form 의 state 의 validate() 함수를 호출하면 form 하위의 입력 위젯의 validator 함수가 자동 호출..
              //매개변수가 현재 유저가 입력한 값..
              //null 이 리턴되면 유효하다.. 즉 에러메시지 없다..
              //문자열 리턴.. invalid... 에러메시지..
              if(value?.isEmpty ?? false){
                return 'enter your last name';
              }
              return null;
            },
            onSaved: (value){
              //form 의 state 의 save() 함수 호출하는 순간 자동 호출.. 매개변수는 입력값..
              user.lastName = value;
            },
          ),
          ElevatedButton(
            onPressed: (){
              //key 를 이용해서 Form 위젯의 State 객체 획득...
              var form = formKey.currentState;
              if(form?.validate() ?? false){
                //모든 하위의 validator 함수가 호출되어 모드 null 리턴하면 true, 하나라도 문자열을 리턴하면 false
                form?.save();
                print('${user.firstName} - ${user.lastName}');
              }
            },
            child: Text('SAVE'),
          )
        ],
      ),
    );
  }
}