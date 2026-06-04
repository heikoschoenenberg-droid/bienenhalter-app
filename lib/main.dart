import 'package:flutter/material.dart';

import 'app/bienenhalter_app.dart';
import 'core/services/app_repositories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppRepositories.instance.initialize();
  runApp(const BienenhalterApp());
}
