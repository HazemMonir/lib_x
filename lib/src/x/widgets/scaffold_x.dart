import 'package:lib_x/lib_x.dart';

class ScaffoldX extends StatefulWidget {
  final Widget body;
  final Widget? appBar;
  final double? appBarHeight;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;
  final Widget? fab;
  final FloatingActionButtonLocation? fabLocation;

  final BoxConstraints? constraints;
  final Color? bgColor;
  final DecorationImage? bgDecorationImage;
  final TextStyle textStyle;
  final bool safeArea;
  final bool scrollView;
  final VoidCallback? onInit;

  const ScaffoldX({
    Key? key,
    required this.body,
    this.appBar,
    this.drawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.fab,
    this.bgColor,
    this.constraints,
    this.textStyle = const TextStyle(color: black, fontSize: 16),
    this.fabLocation,
    this.appBarHeight = 60,
    this.bgDecorationImage,
    this.onInit,
    this.safeArea = true,
    this.scrollView = false,
  }) : super(key: key);

  @override
  State<ScaffoldX> createState() => _ScaffoldXState();
}

class _ScaffoldXState extends State<ScaffoldX> {
  @override
  void initState() {
    widget.onInit;
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
    PreferredSize preferredSize() => PreferredSize(
          preferredSize: Size.fromHeight(widget.appBarHeight!),
          child: widget.appBar!,
        );

    Widget scrollableBody() => widget.scrollView
        ? SingleChildScrollView(child: widget.body)
        : widget.body;

    Widget safeBody() =>
        widget.safeArea ? SafeArea(child: scrollableBody()) : scrollableBody();

    LayoutBuilder layoutBuilder() => LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            return DefaultTextStyle(
              style: widget.textStyle,
              child: Constrained(
                constraints: widget.constraints ?? constraints,
                child: Container(
                  decoration: BoxDecoration(
                    image: widget.bgDecorationImage,
                  ),
                  child: safeBody(),
                ),
              ),
            );
          },
        );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
      bottomSheet: widget.bottomSheet,
      floatingActionButton: widget.fab,
      floatingActionButtonLocation: widget.fabLocation,
      backgroundColor: widget.bgColor,
      appBar: widget.appBar != null ? preferredSize() : null,
      body: layoutBuilder(),
    );
  }
}

// E.g.
// class UserPage extends StatelessWidget {
//   final String username;
//   const UserPage({Key? key, required this.username}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return ScaffoldX(
//       onInit: () => debugPrint(username),
//       scrollView: true,
//       appBar: const MyAppBar(),
//       bottomNavigationBar: const MyNavBar(),
//       bgColor: white,
//       bgDecorationImage: const DecorationImage(
//         image: AssetImage('assets/images/bg.png'),
//         fit: BoxFit.fill,
//         opacity: .3,
//       ),
//       body: Center(
//         child: Text('Hello $username'),
//       ),
//     );
//   }
// }
// Or
// class UserPage extends StatefulWidget {
//   final String username;
//   const UserPage({Key? key, required this.username}) : super(key: key);

//   @override
//   State<UserPage> createState() => _UserPageState();
// }

// class _UserPageState extends State<UserPage> {
//     @override
//   void initState() {
//     BackButtonInterceptor.add(myInterceptor);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     BackButtonInterceptor.remove(myInterceptor);
//     super.dispose();
//   }

//   FutureOr<bool> myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
//     X.back();
//     return true;
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(...);
//   }
// }