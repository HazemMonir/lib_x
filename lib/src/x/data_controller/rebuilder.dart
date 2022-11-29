import 'package:lib_x/lib_x.dart';

class ReBuilder extends StatelessWidget {
  final DataController controller;
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
