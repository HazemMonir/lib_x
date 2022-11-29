//
//
class Singleton {
  Singleton._();
  static final Singleton _instance = Singleton._();
  factory Singleton() => _instance;
}
