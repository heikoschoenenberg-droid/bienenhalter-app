import 'package:flutter/material.dart';

import 'app_data_events.dart';

mixin AppDataListener<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    AppDataEvents.changes.addListener(onAppDataChanged);
  }

  @override
  void dispose() {
    AppDataEvents.changes.removeListener(onAppDataChanged);
    super.dispose();
  }

  void onAppDataChanged();
}
