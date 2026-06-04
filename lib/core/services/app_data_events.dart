import 'package:flutter/foundation.dart';

class AppDataEvents {
  const AppDataEvents._();

  static final ValueNotifier<int> changes = ValueNotifier<int>(0);

  static void notifyChanged() {
    changes.value++;
  }
}
