import 'package:lib_x/lib_x.dart';

// useful with listView to persist the scroll state
class PersistStateWidget extends StatefulWidget {
  final Widget child;
  const PersistStateWidget({super.key, required this.child});

  @override
  State<PersistStateWidget> createState() => _PersistStateWidgetState();
}

class _PersistStateWidgetState extends State<PersistStateWidget>
    with AutomaticKeepAliveClientMixin<PersistStateWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
}
