import 'package:flutter/material.dart';

import '../features/dashboard/dashboard_screen.dart';
import '../features/apiaries/apiary_detail_screen.dart';
import '../features/apiaries/apiary_form_screen.dart';
import '../features/apiaries/apiary_list_screen.dart';
import '../features/hives/hive_detail_screen.dart';
import '../features/hives/hive_form_screen.dart';
import '../features/hives/hive_list_screen.dart';
import '../features/honey_book/honey_book_detail_screen.dart';
import '../features/honey_book/honey_book_form_screen.dart';
import '../features/honey_book/honey_book_list_screen.dart';
import '../features/inspections/inspection_create_screen.dart';
import '../features/inspections/inspection_detail_screen.dart';
import '../features/inspections/inspection_history_screen.dart';
import '../features/photo_import/stock_card_import_screen.dart';
import '../features/tasks/task_form_screen.dart';
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
        return MaterialPageRoute<Object?>(
          settings: settings,
          builder: (context) => _buildScreen(settings),
        );
      },
    );
  }

  Widget _buildScreen(RouteSettings settings) {
    final arguments = settings.arguments;
    final hiveId = arguments is String ? arguments : null;
    final apiaryId = arguments is String ? arguments : null;

    return switch (settings.name) {
      AppRoutes.dashboard => const DashboardScreen(),
      AppRoutes.apiaries => const ApiaryListScreen(),
      AppRoutes.apiaryDetail => ApiaryDetailScreen(apiaryId: apiaryId),
      AppRoutes.apiaryForm => ApiaryFormScreen(
        arguments: arguments is ApiaryFormArguments ? arguments : null,
      ),
      AppRoutes.hives => const HiveListScreen(),
      AppRoutes.hiveDetail => HiveDetailScreen(hiveId: hiveId),
      AppRoutes.hiveForm => HiveFormScreen(
        arguments: arguments is HiveFormArguments ? arguments : null,
      ),
      AppRoutes.honeyBook => const HoneyBookListScreen(),
      AppRoutes.honeyBookDetail => HoneyBookDetailScreen(
        entryId: arguments is String ? arguments : null,
      ),
      AppRoutes.honeyBookForm => HoneyBookFormScreen(
        arguments: arguments is HoneyBookFormArguments ? arguments : null,
      ),
      AppRoutes.inspectionCreate => InspectionCreateScreen(
        arguments: arguments is InspectionFormArguments
            ? arguments
            : InspectionFormArguments(hiveId: hiveId),
      ),
      AppRoutes.inspectionDetail => InspectionDetailScreen(
        inspectionId: arguments is String ? arguments : null,
      ),
      AppRoutes.inspectionHistory => InspectionHistoryScreen(hiveId: hiveId),
      AppRoutes.stockCardImport => const StockCardImportScreen(),
      AppRoutes.tasks => const TaskListScreen(),
      AppRoutes.taskForm => TaskFormScreen(
        arguments: arguments is TaskFormArguments ? arguments : null,
      ),
      _ => const DashboardScreen(),
    };
  }
}
