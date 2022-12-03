import 'package:lib_x/lib_x.dart';

// constrained widget
class Constrained extends StatelessWidget {
  final BoxConstraints constraints;
  final Alignment? alignment;
  final Widget child;
  const Constrained({
    Key? key,
    required this.constraints, // the BoxConstraints
    required this.child, // child to be constrained
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

// quick drawer button
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
    return IconButton(
      color: color,
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: drawerIcon(
        size: iconSize ?? 30,
        color: iconColor ?? Colors.black,
      ),
    );
  }
}

// quick line widget to use as a separator
class LineWidget extends StatelessWidget {
  // default line height is 0
  final double? height;
  // default thikness is 1
  final double? thikness;
  // default line color is transparent black
  final Color? color;

  const LineWidget({super.key, this.height, this.thikness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 0,
      thickness: thikness ?? 1,
      color: color ?? black.withOpacity(.2),
    );
  }
}

// just like padding widget but for the OCD
class Margin extends StatelessWidget {
  // default margin is 10 all directions
  final EdgeInsets margin;
  // a required child widget
  final Widget child;

  const Margin({
    super.key,
    this.margin = const EdgeInsets.all(10),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: child,
    );
  }
}
