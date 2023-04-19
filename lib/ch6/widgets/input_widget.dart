import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//radio 에 지정하고자 하는 값..
enum Platforms { android, ios }

class TextFieldWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextFieldWidgetState();
  }
}
class TextFieldWidgetState extends State<TextFieldWidget>{
  //유저 입력 글 획득을 위해서..
  var inputController = TextEditingController();
  //입력 글 수..
  int textCount = 0;

  bool? isChecked = false;//checkbox..
  String? selectPlatform;//radio
  DateTime dateValue = DateTime.now();//datepicker 값..
  TimeOfDay timeValue = TimeOfDay.now();//timepicker 값..
  double sliderValue = 0.0;//slider 값..
  bool switchOn = false;//switch 값..

  //controller 에 값이 한자한자 입력시마다.. 호출..
  printLatestValue(){
    setState(() {
      textCount = inputController.text.length;
    });
  }
  //datepicker 띄우는 함수..
  Future datePicker() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2016),
        lastDate: DateTime(2030)
    );
    if(picked != null)setState(() {
      dateValue = picked;
    });
  }
  Future timePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    if(selectedTime != null) setState(() {
      timeValue = selectedTime;
    });
  }
  setSliderValue(double value){
    setState(() {
      sliderValue = value;
    });
  }
  onSwitchChanged(bool value){
    setState(() {
      switchOn = value;
    });
  }
  @override
  void initState() {
    super.initState();
    inputController.addListener(printLatestValue);
  }
  @override
  void dispose() {
    super.dispose();
    inputController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            style: TextStyle(fontSize: 15.0),
            decoration: InputDecoration(
              labelText: "Name",
              prefixIcon: Icon(Icons.input),
              border: OutlineInputBorder(),
              hintText: "Hint Text",
              helperText: "이름을 입력하세요..",
              counterText: "$textCount characters",
            ),
            controller: inputController,
          ),
          Row(
            children: [
              Checkbox(
                  value: isChecked,
                  onChanged: (bool? value){
                    setState(() {
                      isChecked = value;
                    });
                  }
              ),
              Text('checkbox is $isChecked')
            ],
          ),
          Row(
            children: [
              Radio(
                value: "android",
                groupValue: selectPlatform,
                onChanged: (String? value){
                  setState(() {
                    selectPlatform = value;
                  });
                },
              ),
              Text('android')
            ],
          ),
          Row(
            children: [
              Radio(
                value: "ios",
                groupValue: selectPlatform,
                onChanged: (String? value){
                  setState(() {
                    selectPlatform = value;
                  });
                },
              ),
              Text('ios')
            ],
          ),
          ElevatedButton(
              onPressed: datePicker,
              child: Text('DatePicker')
          ),
          Text('date : ${DateFormat('yyyy-MM-dd').format(dateValue)}'),
          ElevatedButton(
              onPressed: timePicker,
              child: Text('TimePicker')
          ),
          Text('time : ${timeValue.hour}:${timeValue.minute}'),
          Slider(
              min: 0,
              max: 10,
              value: sliderValue,
              onChanged: setSliderValue
          ),
          Text('slider : $sliderValue'),
          Switch(
              value: switchOn,
              onChanged: onSwitchChanged
          ),
          Text('switch : $switchOn'),
          ElevatedButton(
              onPressed: (){
                print('submit: ${inputController.text}');
              },
              child: Text('submit')
          )
        ],
      ),
    );
  }
}