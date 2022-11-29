import 'package:lib_x/lib_x.dart';

class ReactiveBuilder<T> extends StatelessWidget {
  final ValueController<T> controller;
  final Function builder;
  const ReactiveBuilder({
    super.key,
    required this.controller,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller.listenable,
      builder: (_, value, __) => builder(value),
    );
  }
}
