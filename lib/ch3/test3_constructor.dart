// 생성자

class User {
  String? name;
  int? age;

  User(this.name, this.age);

  User.one();
  User.two(String name);
  User.three(String name, int age) : this.one();
}

class Singleton {
  int? data;
  static final Singleton _instance = Singleton._privateConstructor();

  factory Singleton() {
    return _instance;
  }

  Singleton._privateConstructor();
}