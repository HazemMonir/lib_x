// ignore_for_file: constant_identifier_names

import 'package:lib_x/lib_x.dart';

const String Root = '/';
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

abstract class X implements Singleton {
  static late SingletonFlutterWindow
      _window; // private: used to set onPlatformBrightnessChanged
  static late MaterialApp
      _materialApp; // private: used to config the MaterialApp.router
  static late RoutemasterDelegate
      routerDelegate; // RoutemasterDelegate: from routemaster package
  static const RoutemasterParser routeParser =
      RoutemasterParser(); // RoutemasterParser: from routemaster package

  static BuildContext get currentContext =>
      _navigatorKey.currentContext!; // getter: for the current context
  static MediaQueryData get mediaQuery =>
      MediaQuery.of(currentContext); // getter: to MediaQueryData
  static ThemeData get theme =>
      Theme.of(currentContext); // getter: for the current active theme
  static final ValueController<ThemeMode> themeMode = ValueController<
          ThemeMode>(
      sysThemeMode); // ValueController: for a ReactiveBuilder to change the ThemeMode

  static bool isOpenModal = false; // bool:

  static String currentPath = Root; // current path
  static late Map<String, String>?
      currentPathParameters; // Map: current path parameters
  static late Map<String, String>?
      currentQueryParameters; // Map: current path queries paramaters

  // used to config MaterialX widget
  static void config({
    required SingletonFlutterWindow
        window, // the window attatched when app starts
    required RouteMap
        routeMap, // RouteMap: the paths and their corresponding scaffolds
    required MaterialApp
        app, // MaterialApp: contains themes and locales configs
  }) {
    setPathUrlStrategy();
    routerDelegate = RoutemasterDelegate(
      routesBuilder: (BuildContext context) => routeMap,
      navigatorKey: _navigatorKey,
    );

    _window = window;
    _materialApp = app;
    _configThemeMode();
  }

// private: config theme mode options
  static void _configThemeMode() {
    final bool isAuto = _materialApp.theme != null &&
        _materialApp.darkTheme != null &&
        (_materialApp.themeMode == null ||
            _materialApp.themeMode == ThemeMode.system);

    if (isAuto) {
      _window.onPlatformBrightnessChanged = _updateThemeMode;
      themeMode.onChange = _updateStatusBar;
      Future.delayed(const Duration(seconds: 1), () {
        themeMode.update(sysThemeMode);
        _updateStatusBar();
      });
    }
  }

  // private: to update theme mode and the statusbar color & brightness accordingly
  static void _updateThemeMode() {
    themeMode.update(sysThemeMode);
    _updateStatusBar();
  }

  // private: to update the statusBar color & brightness
  static void _updateStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: transparent,
        statusBarIconBrightness: theme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
    );
  }

  // to switch theme mode programmatically
  static void switchTheme({ThemeMode? to}) {
    late ThemeMode value;
    late VoidCallback? sysOnChange;

    if (to != ThemeMode.system) {
      sysOnChange = null;
      value = to ??
          (theme.brightness == Brightness.dark
              ? ThemeMode.light
              : ThemeMode.dark);
    } else {
      sysOnChange = _updateThemeMode;
      value = sysThemeMode;
    }

    _window.onPlatformBrightnessChanged = sysOnChange;
    themeMode.update(value);
  }

  // to force portrait orientation
  static void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // to force landscape orientation
  static void forceLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // to allow all orientations
  static void allowAutoOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  // private: to set current path paramaters and quries
  static void _setCurrentPath() {
    currentPath = routerDelegate.currentConfiguration!.path;
    currentPathParameters = routerDelegate.currentConfiguration!.pathParameters;
    currentQueryParameters =
        routerDelegate.currentConfiguration!.queryParameters;
    debugPrint('Current path: $currentPath');
  }

  static bool _enabledBack = true;
  // back to previous route chronologically
  static void back() {
    if (isOpenModal) {
      isOpenModal = false;
      pop();
    } else if (_enabledBack && routerDelegate.history.canGoBack) {
      routerDelegate.history.back();
      _enabledBack = false;
      _setCurrentPath();
      Timer(const Duration(seconds: 1), () => _enabledBack = true);
    }
  }

  // to a defined path in the RouteMap
  static void to({required String path}) {
    routerDelegate.push(path);
    _setCurrentPath();
  }

  // to path and prevent back
  static void offTo({required String path}) {
    routerDelegate.replace(path);
    _setCurrentPath();
  }

  // back to any previous route in the material route stack
  static void backTo({required String path}) {
    routerDelegate.popUntil(((routeData) => routeData.path != path));
    _setCurrentPath();
  }

  // open drawer programmatically
  static void openDrawer() => Scaffold.of(currentContext).openDrawer();

  // dismiss keyboard programmatically
  static void dissmissKeyboard() => FocusScope.of(currentContext).unfocus();

  // show snackBar
  static void showSnackBar({required SnackBar snackBar}) =>
      ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);

  // show notification widget in overlay
  static void showNotification({
    required Widget widget, // the notification widget
    bool dismissable = true, // if notification widget is dismissable
    VoidCallback? onDismiss, // callback on dismiss
    VoidCallback? onTap, // callback onTap
    Duration duration = const Duration(
        seconds: 5), // the duration before dismissing the notification widget
    NotificationPosition position =
        NotificationPosition.top, // position of notification widget
  }) {
    if (onTap != null) {
      widget = GestureDetector(
        onTap: onTap,
        child: widget,
      );
    }
    if (dismissable) {
      widget = Dismissible(
        key: Key(genId()),
        onDismissed: (direction) => onDismiss,
        child: widget,
      );
    }

    showOverlayNotification(
      (BuildContext context) => widget,
      duration: duration,
      position: position,
    );
  }

  // show widget in bottomSheet
  static void showBottomSheet({required Widget widget}) => showModalBottomSheet(
        context: currentContext,
        isScrollControlled: true,
        builder: (BuildContext context) => widget,
      );

  // show dialog widget in a material modal
  static void showModal({
    required Widget widget, // dialog widget
    bool safeArea = true, // bool: is wrapped with safeArea
    bool dismissable = true, // bool: is dialog dismissable when tapped outside
    Color? barrierColor, // Color: the barrier background color
  }) {
    isOpenModal = true;
    showDialog(
      // barrierDismissible: true, // doesn't work
      useSafeArea: safeArea,
      barrierColor: barrierColor ?? black.withOpacity(.33),
      context: currentContext,
      builder: (BuildContext context) => Material(
        child: dismissable ? DismissableModal(child: widget) : widget,
      ),
    );
  }

  // to pop modal, bottomSheet, drawer, or keyboard
  static void pop() => Navigator.of(currentContext, rootNavigator: true).pop();
}
