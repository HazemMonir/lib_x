import 'package:lib_x/lib_x.dart';

class Constrained extends StatelessWidget {
  final BoxConstraints constraints;
  final Alignment? alignment;
  final Widget child;
  const Constrained({
    Key? key,
    required this.constraints,
    required this.child,
    this.alignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: ConstrainedBox(
        constraints: constraints,
        child: child,
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  final Color? color;
  final Color? iconColor;
  final double? iconSize;

  const DrawerButton({
    Key? key,
    this.iconColor,
    this.iconSize,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Icon drawerIcon = Icon(
      Icons.menu_rounded,
      size: iconSize ?? 30,
      color: iconColor ?? Colors.black,
    );
    return IconButton(
      color: color,
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: drawerIcon,
    );
  }
}

class LineWidget extends StatelessWidget {
  final double? height;
  final double? thikness;
  final Color? color;
  const LineWidget({Key? key, this.height, this.thikness, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 0,
      thickness: thikness ?? 1,
      color: color ?? black.withOpacity(.2),
    );
  }
}

class Margin extends StatelessWidget {
  final EdgeInsets margin;
  final Widget child;
  const Margin({super.key, required this.margin, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}
