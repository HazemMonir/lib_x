import 'package:lib_x/lib_x.dart';

class ValueController<T> {
  late ValueNotifier<T> _notifier;
  late T value = _notifier.value;
  late ValueListenable listenable = _notifier;

  ValueController(this.value) {
    _notifier = ValueNotifier<T>(value);
  }

  void update(T v) {
    value = v;
    _notifier.value = v;
  }

  set onChange(VoidCallback callback) => _notifier.addListener(callback);

  void dispose() => _notifier.dispose();
}
