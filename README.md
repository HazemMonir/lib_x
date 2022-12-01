# __lib_x__
<br>

__lib_x__ is a simple library which includes some well tested, lightweight, and commonly needed packages. And on top of those packages, there're some preconfigured solutions and simplifications to help you quickly focus on the scaffold within few steps.
<br><br>

### __lib_x__ is designed to complement 2 things:
  - The __Object-Oriented__ nature of __Dart__ by separating between the ```View``` logic & the ```Data``` logic in a __Flutter__ application.
  - The __Flutter Framework__ methods with some simplifications. So we're making things the __Flutter__ way.
<br><br>

### The purpose of this library:
- Grouping some basic packages into one.
- Avoiding some of the commonly needed boilerplate.
- Providing solutions for [__Routing__, __State Management__, __Data Providers__].
- Helping with the __Design Pattern & Separation Of Concers__.
- __Semantic & Self-Explanatory Naming__.
<br><br>

### Packages included in this liberary:
  - [routemaster](https://pub.dev/packages/routemaster)
  - [overlay_support](https://pub.dev/packages/overlay_support)
  - [url_strategy](https://pub.dev/packages/url_strategy)
  - [back_button_interceptor](https://pub.dev/packages/back_button_interceptor)
  - [google_fonts](https://pub.dev/packages/google_fonts)
  - [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
  - [flutter_svg](https://pub.dev/packages/flutter_svg)
  - [mime](https://pub.dev/packages/mime)
  - [http](https://pub.dev/packages/http)
  - [intl](https://pub.dev/packages/intl)
  - [shimmer](https://pub.dev/packages/shimmer)
  - [crypto](https://pub.dev/packages/crypto)

<br>

By installing __```lib_x```__, you have these awesome packages already installed, and you can directly import them in your application. Plus, you can also use one of the following solutions.
<br><br>

# __Solutions__
  - [__MaterialX & X Controller__](#MaterialX-&-X-Controller)
    - [__MaterialX__](#Widget-MaterialX)
    - [__X Controller__](#abstract-class-X)
      - [__Theme Management__](#Theme-Management)
      - [__Route Management__](#Route-Management)
  - [__ScaffoldX__](#ScaffoldX)
  - [__DataProvider__](#DataProvider)
  - [__DataController & ReBuilder__](#DataController-&-ReBuilder)
    - [__DataController__](#DataController)
    - [__ReBuilder__](#ReBuilder())
  - [__ValueController & ReactiveBuilder__](#ValueController-&-ReactiveBuilder)
  - [__Bonus Widgets__](#Widgets)
<br><br>

## __MaterialX & X Controller__
<br>

  We often need more than just ```push()``` & ```pop()``` which the simple MaterialApp provides. For a real world application, we need navigation via url, deep linking, routing without depending on ```context```... And for that we need to configure Navigator 2.0 via ```MaterialApp.router()``` or ```MaterialX()``` with the controller class __```X```__ that separates & encapsulates all the routing and themeing concerns.
<br><br>

### __```Widget MaterialX```__<br>
Takes these 2 named parameters and builds a ```MaterialApp.router() ``` to be used in the ```runApp()``` function:

- ```MaterialApp materialApp```: MaterialApp that contains the themes, and locale concerns. Not the routing options.

- ```RouteMap routeMap```: A map between the routing patterns and their corresponding ```Scaffold```s.

E.g. <br>
lib/main.dart
```dart
void main() {
  runApp(const MyApp());
}
```
lib/src/views/const/route_map.dart
```dart
const String LoginPath = '/login';
const String RootPath = '/';
const String UserPath = '/user/';
const String ContactPath = '/contact/';
const String PostPath = '/post/';

// if authentication, guarded routes
bool isLoggedIn = true;

final RouteMap routeMap = RouteMap(
  routes: {
    LoginPath: (info) => const MaterialPage(child: LoginPage()), // without Guarding
    RootPath: (info) => isLoggedIn // with Guarding
      ? const MaterialPage(child: HomePage())
      : const Redirect(LoginPath),
    UserPath + ':username': (RouteData info) => isLoggedIn
      ? MaterialPage(child: UserPage(username: info.pathParameters['username']!))
      : const Redirect(LoginPath),
    UserPath + ':username' + ContactPath : (RouteData info) => isLoggedIn
      ? MaterialPage(child: ContactUserPage(username: info.pathParameters['username']!))
      : const Redirect(LoginPath),
    PostPath + ':postId': (RouteData info) => isLoggedIn
      ? MaterialPage(child: PostPage(postId: info.pathParameters['postId']!))
      : const Redirect(LoginPath),
    PostPath + ':postId/:commentId': (RouteData info) => isLoggedIn
      ? MaterialPage(
          child: CommentPage(
          postId: info.pathParameters['postId']!,
          commentId: info.pathParameters['commentId']!,
        ))
      : const Redirect(LoginPath),
    // ... and so on
  },
  onUnknownRoute: (_) => const MaterialPage(child: NotFoundPage()), // fallback route
);
```
lib/src/views/const/material_app.dart
```dart
final MaterialApp materialApp = MaterialApp(
  title: 'Contacts App',
  debugShowCheckedModeBanner: false,
  theme: myLightTheme,
  darkTheme: myDarkTheme,
  themeMode: ThemeMode.system,
);
```
lib/src/views/my_app.dart
```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialX(
        materialApp: materialApp,
        routeMap: routeMap,
      );
  }
}

// now from anywhere in your app you can navigate like this:
// X.to(UserPath + '_username_');
```
[For more info about RouteMap type and the package routemaster.](https://pub.dev/packages/routemaster)
<br><br>

### __```abstract class X```__ <br>
It's the controller class for the ```MaterialX``` widget, and it has the following interface:<br>

Notes:
  - ```abstract class``` in __Dart__ simply means it's not to be instantiated, and can have abstract methods.
  - __Abstract Method__ in __Dart__ is a method to be implemented. It's a function without a body inside an ```abstract class``` e.g. the famous ```build``` method in the  ```abstract class StatelessWidget```.
<br><br>

#### __Theme Management__
<br>

- ```ThemeData X.theme``` => returns ```ThemeData``` object of the current context

- ```MediaQueryData X.mediaQuery``` => returns ```MediaQueryData``` object of the current context

- ```ValueController<ThemeMode> X.themeMode``` => is the themeMode controller of ```MaterialX```. If you provided both light and dark themes in the materialApp. MaterialX will change automatically with system themeMode changes, unless you specified a themeMode with a different value than ```ThemeMode.system```.

- ```void X.switchTheme({ThemeMode? to})``` => it takes one of these values ```[ThemeMode.system, ThemeMode.dark, ThemeMode.light]``` and updates the value of ```X.themeMode```. It also updates the stausBar ```color``` and ```brightness``` accordingly.  If you didn't pass a value of themeMode, it will just switch the current themeMode to the opposite, and it will stop listening to the system themeMode changes. To change theme with system again, use<br> ```X.switchTheme(to: ThemeMode.system);```

- ```void X.setStatusBar({Color? color, Brightness? brightness})``` => to set the color and brightness of the statusBar.

- ```void X.forcePortrait()``` => to force Portait Orientation.

- ```void X.forceLandscape()``` => to force Landscape Orientation.

- ```void X.allowAutoOrientation()``` => to allow both Portait & Landscape Orientations.
<br><br>

#### __Route Management__
<br>

- ```String X.currentPath``` => returns a ```String``` of the current path

- ```Map<String, String>? X.currentPathParameters``` => returns a ```Map``` of the current path parameters, e.g. if the current path is 'user/12345', it will return ```{id: '12345'}```

- ```Map<String, String>? X.currentQueryParameters``` => returns a ```Map``` of the current path query parameters, e.g. 'user?id=12345' returns ```{id: '12345'}```

- ```void X.to({required String path})``` => navigate to path, that is defined in the ```RouteMap```.

- ```void X.offTo({required String path})``` => navigate to path and prevents back.

- ```void X.back()``` => go back to previous route chronologically.

- ```void X.backTo({required String path})``` => pop all routes till the provided path.

- ```void X.openDrawer()``` => open Drawer programmatically.

- ```void X.dissmissKeyboard()``` => close device keyboard if it's open.

- ```void X.showSnackBar({required SnackBar snackBar})``` => show snackBar.

- ```void X.showNotification({})``` => show notification overlay. It takes the following named parameters:
```dart
X.showNotification({
    required Widget widget,
    bool dismissable = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
    Duration duration = const Duration(seconds: 5),
    NotificationPosition position = NotificationPosition.top,
  })
```

- ```void X.showBottomSheet({required Widget child})``` => show this widget in bottomSheet.

- ```void X.showModal({})``` => open modal route with this dialoug widget. It takes the following named parameters:
```dart
X.showModal({
    required Widget widget,
    bool safeArea = true,
    bool dismissable = true,
    Color? barrierColor,
  })
```

- ```bool X.isOpenModal``` => to check if modal is open.

- ```void X.pop()``` => pop modal, bottomSheet, drawer, or keyboard.
<br><br>

## __ScaffoldX__
<br>

Right after the declaration of materialApp, routeMap, and MyApp, we need to create the pages that contains a ```Scaffold``` widget and corresponds with the defined paths in the ```routeMap```. ```ScaffoldX``` is a quick way to compose a scaffold with default configurations. It has the following named parameters:

```dart
Widget ScaffoldX({
  required Widget body,
  Color? bgColor,
  DecorationImage? bgDecorationImage,
  Widget? appBar,
  double appBarHeight = 60,
  Widget? drawer,
  Widget? bottomNavigationBar,
  Widget? bottomSheet,
  Widget? fab, // FloatingActionButton
  FloatingActionButtonLocation? fabLocation,
  BoxConstraints? constraints,
  TextStyle textStyle = const TextStyle(color: black, fontSize: 16),
  VoidCallback? onInit,
  bool safeArea = true,
  bool scrollView = false,
})
``` 

#### E.g.
```dart
class UserPage extends StatelessWidget {
  final String username;
  const UserPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScaffoldX(
      onInit: () => debugPrint(username),
      appBar: const MyAppBar(),
      bottomNavigationBar: const MyNavBar(),
      bgDecorationImage: const DecorationImage(
        image: AssetImage('assets/images/bg.png'),
        fit: BoxFit.fill,
        opacity: .3,
      ),
      body: Center(
        child: Text('Hello $username'),
      ),
    );
  }
}
```

Note: If you're not going to use ScaffoldX, make sure to implement the ```BackButtonInterceptor``` to handle the back guesture.

#### E.g.
```dart
class UserPage extends StatefulWidget {
  final String username;
  const UserPage({Key? key, required this.username}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}
class _UserPageState extends State<UserPage> {
    @override
  void initState() {
    BackButtonInterceptor.add(myInterceptor);
    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  FutureOr<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    X.back();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(...);
  }
}
```
<br>

## __DataProvider__
#### __```Widget DataProvider<T>```__ 
Instead of passing the data from parent widget to children to sub-children... via parameters, which gets messy very quickly, we need the concept of data provider class. And for that we can either use ```InheritedWidget``` or ```DataProvider``` to assign the desired data to a widget, and _all_ and _only_ the __descendant children & sub-children__ widgets will have access to that data via the static method ```of(context)```.
<br><br>

__```DataProvider```__ needs 3 arguments:
1. Data Object ```data``` of any type ```T```, like ```UserModel```, ```List<String>```, ... etc.
2. ```Widget child``` that holds the data for its descendant widgets to access.
3. ```static of(context)``` method that returns the provider class instance of this context.

#### E.g. models/user_model.dart
```dart
// If we have a user model class like this
class UserModel {
  final String id;
  final String username;

  UserModel({required this.id, required this.username});
}

// To create a userModel provider
class UserProvider extends DataProvider<UserModel> {
  // Declare the desired data you want the class to provide
  final UserModel userModel;

  const UserProvider({
    super.key,
    required this.userModel, // first argument: require the declared data object
    required super.child, // second argument: require & pass child to the super class
  }) : super(data: userModel); // pass the data to the super class

  // third argument: without it the class is useless
  // Declare a static method that returns the provider instance of(context)
  static UserProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UserProvider>()!;
  // just copy the method and change the class name.
}
```
views/pages/user_page.dart
```dart
// Now the user page could be like this
class UserPage extends StatelessWidget {
  final String username;
  const UserPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldX(
      body: UserProvider(
        userModel: UserModel(
            id: 'id', 
            username: username
          ),
        child: ProfileWidget(),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // you can access userModel of context 
    final UserModel userModel = UserProvider.of(context).userModel;
    return Text(userModel.username);
  }
}

// And all the descendant widgets of ProfileWidget have access to userModel data
```
<br>

## __DataController & ReBuilder__

```StatefulWidget``` is a very useful widget in a lot of situations, except when it comes to data management. In a real world application, we need to decouple the __Data Layer__ from the __View Layer__, and put each layer separately, like in __MVC__ design model. That's why this solution is divided in 2 separate classes, a view class "widget", and data controller class.<br><br>

1. ```DataController```:
It's an extension of ```ChangeNotifier``` with a better name. This would be the controller class of a ```Rebuilder``` widget. This class should encapsulte all the data logic separately from the view logic. When data changes, and the ```@protected update()``` method is called, the ```ReBuilder``` widget will rebuild to reflect the changes of data.
<br><br>
Notes: 
    - ```update()``` is protected by design to force separation of concers.<br>
    - ```@protected``` method in __Dart__ means: It cannot be called from outside the class. So if you're going to do crud operations on your data model, it must be inside the class.
<br><br>

2. ```ReBuilder``` :
It's a widget built on top of ```AnimatedBuilder``` widget that will rebuild when the controller changes. and it takes 2 named parameters: <br>
    1. ```DataController controller```: an instance of a DataController object.
    2. ```Function builder```: a function that returns a ```Widget```, which will rebuild when the controller changes.<br>

#### E.g.
```dart
// Instead of StatefulWidget and changing the data with setState(). we'll create 2 separate layers:
// 1. data model that extends DataController
class UserModel extends DataController {
  final String id;
  String username;

  UserModel({required this.id, required this.username});

  // we manage the data state here inside the data class
  void changeUsername(String newName) {
    username = newName;
    update(); // triggers Rebuilder to rebuild
  }
}

// 2. view model 'widget' that reflect the state of the data model using ReBuilder
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel userModel = UserProvider.of(context).userModel;
    return ReBuilder(
      controller: userModel, // first parameter: an instance of DataController
      builder: () { // second paramter: a function that returns a widget
        // whenever the username changes and update has been called, this widget will reflect these changes
        return Text(userModel.username);
      }
    );
  }
}
```
<br>

-  Note: ```ReBuilder``` widget is still a __Statefull__ widget deep under the hood, but with an external controller that triggers __setState()__ for us.
<br><br>

## __ValueController & ReactiveBuilder__
Sometimes we only have one independent value that we need to listen to its state. Again, we'll create 2 separate objects. ```ValueController<T>``` to control a value of some type, and ```ReactiveBuilder``` that refelcts the change of that value. <br>

1. ```ValueController<T>```: 
It's a value controller object built on top of ```ValueNotifier```. It has a the following interface:
<br><be>

    - ```value``` => returns the current value.
    - ```ValueListenable listenable``` => listenable object that could be used with ```ValueListenableBuilder```.
    - ```void update(T v)``` => to update the value property of type ```T```.
    - ```set onChange(VoidCallback callback)``` => a setter method if you want to attach a callback function that runs whenever the value changes.
    - ```void dispose()``` => valueController cannot be used after calling this method. 
<br><br>

2. ```ReactiveBuilder```
It's a ```StatelessWidget``` on top of ```ValueListenableBuilder``` that rebuilds when the value of the controller updates. And it takes 2 named parameters:<br>
    1. ```ValueController<T>```.
    2. ```Function builder(T value)```: a function with value argument that returns a widget, that rebuilds when the value of controller changes.<br>
#### E.g.
```dart
final ValueController<ThemeMode> themeModeController = ValueController<ThemeMode>(ThemeMode.dark);

class SwitchThemeButton extends StatelessWidget {
  const SwitchThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeMode value() => themeModeController.value == ThemeMode.dark
        ? ThemeMode.light
        : ThemeMode.dark;

    // when this button pressed, the AdaptiveText widget will change the text color, 
    // because it has ReactiveBuilder which is controlled by themeModeController

    return TextButton(
      onPressed: () => themeModeController.update(value()),
      child: const Text('Change Theme'),
    );
  }
}

class AdaptiveText extends StatelessWidget {
  final String text;
  final Color? lightModeC;
  final Color? darkModeC;
  final double? fontSize;

  const AdaptiveText(
    this.text, {
    super.key,
    this.lightModeC,
    this.darkModeC,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveBuilder(
      controller: themeModeController,
      builder: (ThemeMode mode) => Text(
        text,
        style: TextStyle(
          color: mode == ThemeMode.dark 
            ? darkModeC ?? white 
            : lightModeC ?? black,
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
```
<br><br>

## __Widgets__ 
<br>

#### ```Widget PersistStateWidget(required Widget child)``` 
- It could be useful if you have e.g. ScrollView, and you want to maintain its state like scoll position when navigating to other tabs.
#### E.g.
```dart
class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> myList = List.generate(100, (index) => Text(index.toString())).toList();
    // wrap ListView with PersistStateWidget to maintain its scroll state
    return PersistStateWidget(
      child: ListView.builder(
        itemBuilder: (context, index) => myList[index],
      ),
    );
  }
}
```
<br>

#### ```Widget DismissModalWidget(required Widget child)``` <br><br>
- If you will push a modal route and you want it to pop when clicked outside of the dialog widget, wrap the dialog widget with ```DismissModalWidget```.It's more reliable than ```barrierDismissible``` in the native function ```showDialog()```.
#### E.g.
```dart
class MyDialog extends StatelessWidget {
  const MyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Dialog'));
  }
}

class ShowMyDialogButton extends StatelessWidget {
  const ShowMyDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog(
        context: context,
        barrierDismissible: true, // not reliable
        builder: (context) {
          return const DismissableModal(child: MyDialog());
        },
      ),
      child: const Text('Show Dismissable Dialog'),
    );
  }
}
```
- Note: The dismissable behavior is the default if you're gonna use ```X.showModal(child: MyDialog())``` instead of showDialog().
<br><br>

### P.S. 
- These are my personal implementations, which I don't know if it will be useful for others or not, but I hope it will be.
- Feel free to suggest more simplifications or optimizations by pulling a request on [Github](https://github.com/HazemMonir/lib_x).
- Feel free extending it or modifying it as you wish.
<br><br>

## Credits does to the authers of the implemented packages & of course the developers of Dart and Flutter

## Happy Coding