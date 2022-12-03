import 'package:lib_x/lib_x.dart';

class ReBuilder extends StatelessWidget {
  // an extension of DataController
  final DataController controller;
  // a builder function that return widget e.g. (){ return Container(); }
  final Function builder;

  const ReBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // AnimatedBuilder extends AnimatedWidget extends StatefulWidget
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) => builder(),
    );
  }
}
