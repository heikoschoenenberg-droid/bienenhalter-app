import 'package:flutter/material.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/hives/hive_detail_screen.dart';
import '../features/hives/hive_list_screen.dart';
import '../features/inspections/inspection_create_screen.dart';
import '../features/inspections/inspection_history_screen.dart';
import '../features/tasks/task_list_screen.dart';
import 'app_routes.dart';
import 'app_theme.dart';

class BienenhalterApp extends StatelessWidget {
  const BienenhalterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bienenhalter-App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      initialRoute: AppRoutes.dashboard,
      onGenerateRoute: (settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (context) => _buildScreen(settings),
        );
      },
    );
  }

  Widget _buildScreen(RouteSettings settings) {
    final hiveId = settings.arguments as String?;

    return switch (settings.name) {
      AppRoutes.dashboard => const DashboardScreen(),
      AppRoutes.hives => const HiveListScreen(),
      AppRoutes.hiveDetail => HiveDetailScreen(hiveId: hiveId),
      AppRoutes.inspectionCreate => InspectionCreateScreen(hiveId: hiveId),
      AppRoutes.inspectionHistory => InspectionHistoryScreen(hiveId: hiveId),
      AppRoutes.tasks => const TaskListScreen(),
      _ => const DashboardScreen(),
    };
  }
}
