import 'package:lib_x/lib_x.dart';

// an extension of InheritedWidget to provides data from context
class DataProvider<T> extends InheritedWidget {
  final T data;

  const DataProvider({
    super.key,
    required this.data, // any type of data
    required super.child, // base widget for the data
  });

  @override
  bool updateShouldNotify(covariant DataProvider oldWidget) =>
      data != oldWidget.data;
}

// E.g.

// class UserModel {
//   final String id;
//   final String username;

//   UserModel({required this.id, required this.username});
// }

// class UserProvider extends DataProvider<UserModel> {
//   final UserModel userModel;

//   const UserProvider({
//     super.key,
//     required this.userModel,
//     required super.child,
//   }) : super(data: userModel);

//   static UserProvider of(BuildContext context) =>
//       context.dependOnInheritedWidgetOfExactType<UserProvider>()!;
// }

// class UserPage extends StatelessWidget {
//   final String username;
//   const UserPage({Key? key, required this.username}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ScaffoldX(
//       body: UserProvider(
//         userModel: UserModel(id: 'id', username: username),
//         child: const ProfileWidget(),
//       ),
//     );
//   }
// }

// class ProfileWidget extends StatelessWidget {
//   const ProfileWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final UserModel userModel = UserProvider.of(context).userModel;
//     return Text(userModel.username);
//   }
// }
