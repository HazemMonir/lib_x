import 'package:lib_x/lib_x.dart';

class DataController extends ChangeNotifier {
  @protected
  void update() => notifyListeners();
}

// class UserModel extends DataController {
//   final String id;
//   String username;

//   UserModel({required this.id, required this.username});

//   void changeUsername(String newName) {
//     username = newName;
//     update();
//   }
// }

// class ProfileWidget extends StatelessWidget {
//   const ProfileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UserModel userModel = UserProvider.of(context).userModel;
//     return ReBuilder(
//       controller: userModel,
//       builder: () {
//         return Text(userModel.username);
//       }
//     );
//   }
// }
