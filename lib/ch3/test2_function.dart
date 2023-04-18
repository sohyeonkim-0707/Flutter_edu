// 반복적으로 사용되는 함수 타입이 있다면 typedef 로 선언해놓으면 사용이 편할 수 있다.
typedef MyFunctionType<T, A> = T Function(A arg);



class User{
some(){

}
}



main() {
  // named optional
  // optional 로 선언하면 함수 호출시 매개변수 값이 대입이 안될 수 있다.
  // nullable로 선언하던가 default 값을 대입하던가
  void namedOptional(bool datal, {String data2 = 'hello', int? data3}) {
  }
  namedOptional(true); //ok
  // namedOptional(true, 'world', 10) // error 이름 생략 불가
  namedOptional(true, data2: 'world', data3: 10);
  namedOptional(true, data3: 10, data2: 'world');


  // unnamed optional
  void unnamedOptional(bool data1, [String data2 = 'hello', int? data3]) {}
  unnamedOptional(true); //ok
  unnamedOptional(true, 'world');
  // unnamedOptional(true, data2: 'world', data3:20) //error
  // unnamedOptional(true,20,'world'); //error

  // Funtion type
  int some(int a) {
    return a * 10;
  }
  Function testFun(int Function(int a) argFun) {
    argFun(10);
    return some;
  }
  var result = testFun((a) => a+10);
  result(10);

  int testFun2(MyFunctionType<int, int> argFun){
    return 10;
  }
  testFun2(some);

  User obj1 = User();
  obj1.some();

  User? obj2 = null;
  obj2?.some();
}