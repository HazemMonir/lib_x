//
// to make a singleton class, use implements Singleton
class Singleton {
  Singleton._();
  static final Singleton _instance = Singleton._();
  factory Singleton() => _instance;
}
