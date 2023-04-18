main(){
  // 모든 변수는 객체이다.
  // 모든 변수는 타입으로 nullable 과 non-null을 구분해야 한다
  int data1 =10;
  bool? data2;
  double? data3;


  print(data1.isEven); // true
  print('$data1, $data2, $data3'); //10, null null

  // data1 = null//error..
  data3 = 10.0;
  data3 = null;

  // casting
  data3 = data1.toDouble();
  int data4 =10.0.toInt();

  String data5 = '10';
  int data6 = int.parse(data5);

  // var 타입유추, dynamic-any 타입
  var a = 10;
  // a = 'hello'; // error
  dynamic b = 10;
  b = 'hello'; // ok

  var c; // 초기값을 주지 않으면 dynamic 으로 유추
  c = 10;
  c = 'hello';

  // list
  List list1 = [10, true, 'hello'];
  list1[0] = 20;
  list1.add(20);

  // 사이즈를 한정짓고 사용하기
  // filled 라는 생성자 이용해서 선언, 아래서 null은 초기값
  List list2 = List.filled(3, null);
  list2[0] = 10;

  // map
  Map map = {1:10, 'two':'hello'};
  map['two'] = 'world';
}