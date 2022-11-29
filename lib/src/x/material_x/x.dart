// ignore_for_file: constant_identifier_names

import 'package:lib_x/lib_x.dart';

const String Root = '/';
final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

abstract class X implements Singleton {
  static late SingletonFlutterWindow _window;
  static late MaterialApp _materialApp;
  static late RoutemasterDelegate routerDelegate;
  static const RoutemasterParser routeParser = RoutemasterParser();

  static BuildContext get currentContext => _navigatorKey.currentContext!;
  static MediaQueryData get mediaQuery => MediaQuery.of(currentContext);
  static ThemeData get theme => Theme.of(currentContext);
  static final ValueController<ThemeMode> themeMode =
      ValueController<ThemeMode>(sysThemeMode);

  static bool isOpenModal = false;

  static String currentPath = Root;
  static late Map<String, String>? currentPathParameters;
  static late Map<String, String>? currentQueryParameters;

  static void config({
    required SingletonFlutterWindow window,
    required RouteMap routeMap,
    required MaterialApp app,
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

  static void _updateThemeMode() {
    themeMode.update(sysThemeMode);
    _updateStatusBar();
  }

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

  static void forcePortrait() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  static void forceLandscape() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static void allowAutoOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  static void _setCurrentPath() {
    currentPath = routerDelegate.currentConfiguration!.path;
    currentPathParameters = routerDelegate.currentConfiguration!.pathParameters;
    currentQueryParameters =
        routerDelegate.currentConfiguration!.queryParameters;
    debugPrint('Current path: $currentPath');
  }

  static bool _enabledBack = true;
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

  static void to({required String path}) {
    routerDelegate.push(path);
    _setCurrentPath();
  }

  static void offTo({required String path}) {
    routerDelegate.replace(path);
    _setCurrentPath();
  }

  static void backTo({required String path}) {
    routerDelegate.popUntil(((routeData) => routeData.path != path));
    _setCurrentPath();
  }

  static void openDrawer() => Scaffold.of(currentContext).openDrawer();

  static void dissmissKeyboard() => FocusScope.of(currentContext).unfocus();

  static void showSnackBar({required SnackBar snackBar}) =>
      ScaffoldMessenger.of(currentContext).showSnackBar(snackBar);

  static void showNotification({
    required Widget widget,
    bool dismissable = true,
    VoidCallback? onDismiss,
    VoidCallback? onTap,
    Duration duration = const Duration(seconds: 5),
    NotificationPosition position = NotificationPosition.top,
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

  static void showBottomSheet({required Widget widget}) => showModalBottomSheet(
        context: currentContext,
        isScrollControlled: true,
        builder: (BuildContext context) => widget,
      );

  static void showModal({
    required Widget widget,
    bool safeArea = true,
    bool dismissable = true,
    Color? barrierColor,
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

  static void pop() => Navigator.of(currentContext, rootNavigator: true).pop();
}
