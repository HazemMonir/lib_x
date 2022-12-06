//
/// to make a singleton class, use implements Singleton

class Singleton {
  Singleton._();
  static final Singleton _instance = Singleton._();
  factory Singleton() => _instance;
}

// E.g.
// class AuthService extends StatefulData implements Singleton {
//   late bool _auth;
//   bool get isLoggedIn => _auth;

//   void login() {
//     // some logic here
//     _auth = true;
//     update();
//   }

//   void logout(){
//     _auth = false;
//     update();
//   }
// }
