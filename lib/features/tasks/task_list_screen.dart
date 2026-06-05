import 'package:flutter/material.dart';

import '../../app/app_colors.dart';
import '../../app/app_routes.dart';
import '../../core/date_format.dart';
import '../../core/models/beekeeper_task.dart';
import '../../core/models/hive.dart';
import '../../core/services/app_data_listener.dart';
import '../../core/services/app_repositories.dart';
import 'task_form_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen>
    with AppDataListener<TaskListScreen> {
  final _searchController = TextEditingController();
  late Future<_TaskListData> _future;
  String _searchQuery = '';
  _TaskStatusFilter _statusFilter = _TaskStatusFilter.all;
  BeekeeperTaskCategory? _categoryFilter;
  BeekeeperTaskPriority? _priorityFilter;
  _TaskDueFilter _dueFilter = _TaskDueFilter.all;

  @override
  void initState() {
    super.initState();
    _future = _loadData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<_TaskListData> _loadData() async {
    debugPrint('TaskListScreen: loading data');
    final repositories = AppRepositories.instance;
    final tasks = await repositories.tasks.getAllSorted();
    final hives = await repositories.hives.getAll();
    debugPrint('TaskListScreen: loaded ${tasks.length} tasks');
    return _TaskListData(tasks: tasks, hives: hives);
  }

  Future<void> _reload() async {
    if (!mounted) {
      return;
    }
    debugPrint('TaskListScreen: reload requested');
    final future = _loadData();
    setState(() {
      _future = future;
    });
    await future;
  }

  @override
  void onAppDataChanged() {
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Aufgaben')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openTaskForm(),
        icon: const Icon(Icons.add),
        label: const Text('Neue Aufgabe'),
      ),
      body: FutureBuilder<_TaskListData>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;
          final filteredTasks = _filterTasks(data);
          final groupedTasks = _groupTasks(filteredTasks);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Aufgabenliste',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              const Text(
                'Offene Aufgaben stehen oben und sind nach Fälligkeit sortiert.',
              ),
              const SizedBox(height: 20),
              _TaskFilters(
                searchController: _searchController,
                searchQuery: _searchQuery,
                statusFilter: _statusFilter,
                categoryFilter: _categoryFilter,
                priorityFilter: _priorityFilter,
                dueFilter: _dueFilter,
                resultCount: filteredTasks.length,
                onSearchChanged: (value) {
                  setState(() => _searchQuery = value);
                },
                onStatusChanged: (value) {
                  setState(() => _statusFilter = value);
                },
                onCategoryChanged: (value) {
                  setState(() => _categoryFilter = value);
                },
                onPriorityChanged: (value) {
                  setState(() => _priorityFilter = value);
                },
                onDueChanged: (value) {
                  setState(() => _dueFilter = value);
                },
              ),
              const SizedBox(height: 20),
              for (final group in groupedTasks.entries) ...[
                _TaskGroupTitle(title: group.key),
                const SizedBox(height: 8),
                for (final task in group.value) ...[
                  _TaskCard(
                    task: task,
                    hive: data.hiveById(task.hiveId),
                    onOpen: () => _openTaskForm(taskId: task.id),
                    onComplete: task.isOpen
                        ? () => _completeTask(task.id)
                        : null,
                  ),
                  const SizedBox(height: 10),
                ],
                const SizedBox(height: 8),
              ],
              const SizedBox(height: 72),
            ],
          );
        },
      ),
    );
  }

  Future<void> _openTaskForm({String? taskId}) async {
    debugPrint('TaskListScreen: opening task form taskId=$taskId');
    final changed = await Navigator.pushNamed(
      context,
      AppRoutes.taskForm,
      arguments: TaskFormArguments(taskId: taskId),
    );
    debugPrint('TaskListScreen: returned from task form changed=$changed');

    if (changed == true && mounted) {
      await _reload();
    }
  }

  Future<void> _completeTask(String taskId) async {
    debugPrint('TaskListScreen: completing task $taskId');
    await AppRepositories.instance.tasks.complete(taskId);
    debugPrint('TaskListScreen: completed task $taskId');
    await _reload();
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Aufgabe wurde als erledigt markiert.')),
    );
  }

  List<BeekeeperTask> _filterTasks(_TaskListData data) {
    final query = _searchQuery.trim().toLowerCase();

    return data.tasks.where((task) {
      final hive = data.hiveById(task.hiveId);
      final matchesSearch =
          query.isEmpty ||
          task.title.toLowerCase().contains(query) ||
          task.description.toLowerCase().contains(query) ||
          hive.number.toLowerCase().contains(query) ||
          task.categoryLabel.toLowerCase().contains(query) ||
          task.priorityLabel.toLowerCase().contains(query);
      final matchesStatus = switch (_statusFilter) {
        _TaskStatusFilter.all => true,
        _TaskStatusFilter.open => task.isOpen,
        _TaskStatusFilter.done => !task.isOpen,
      };
      final matchesCategory =
          _categoryFilter == null || task.category == _categoryFilter;
      final matchesPriority =
          _priorityFilter == null || task.priority == _priorityFilter;
      final matchesDue = _matchesDueFilter(task);

      return matchesSearch &&
          matchesStatus &&
          matchesCategory &&
          matchesPriority &&
          matchesDue;
    }).toList();
  }

  bool _matchesDueFilter(BeekeeperTask task) {
    final today = DateTime.now();
    final currentDay = DateTime(today.year, today.month, today.day);
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final daysUntilDue = dueDate.difference(currentDay).inDays;

    return switch (_dueFilter) {
      _TaskDueFilter.all => true,
      _TaskDueFilter.today => daysUntilDue == 0,
      _TaskDueFilter.overdue => task.isOpen && daysUntilDue < 0,
      _TaskDueFilter.thisWeek => daysUntilDue >= 0 && daysUntilDue <= 7,
    };
  }

  Map<String, List<BeekeeperTask>> _groupTasks(List<BeekeeperTask> tasks) {
    final groups = <String, List<BeekeeperTask>>{};

    for (final task in tasks) {
      final groupName = _groupName(task);
      groups.putIfAbsent(groupName, () => []).add(task);
    }

    return groups;
  }

  String _groupName(BeekeeperTask task) {
    if (!task.isOpen) {
      return 'Erledigt';
    }

    final today = DateTime.now();
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final currentDay = DateTime(today.year, today.month, today.day);
    final daysUntilDue = dueDate.difference(currentDay).inDays;

    if (daysUntilDue < 0) {
      return 'Überfällig';
    }
    if (daysUntilDue == 0) {
      return 'Heute';
    }
    if (daysUntilDue <= 7) {
      return 'Naechste 7 Tage';
    }
    return 'Spaeter';
  }
}

enum _TaskStatusFilter { all, open, done }

enum _TaskDueFilter { all, today, overdue, thisWeek }

class _TaskFilters extends StatelessWidget {
  const _TaskFilters({
    required this.searchController,
    required this.searchQuery,
    required this.statusFilter,
    required this.categoryFilter,
    required this.priorityFilter,
    required this.dueFilter,
    required this.resultCount,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onCategoryChanged,
    required this.onPriorityChanged,
    required this.onDueChanged,
  });

  final TextEditingController searchController;
  final String searchQuery;
  final _TaskStatusFilter statusFilter;
  final BeekeeperTaskCategory? categoryFilter;
  final BeekeeperTaskPriority? priorityFilter;
  final _TaskDueFilter dueFilter;
  final int resultCount;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<_TaskStatusFilter> onStatusChanged;
  final ValueChanged<BeekeeperTaskCategory?> onCategoryChanged;
  final ValueChanged<BeekeeperTaskPriority?> onPriorityChanged;
  final ValueChanged<_TaskDueFilter> onDueChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Aufgaben suchen und filtern',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text('$resultCount Treffer'),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                labelText: 'Titel, Volk, Kategorie oder Prioritaet suchen',
                border: const OutlineInputBorder(),
                suffixIcon: searchQuery.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          searchController.clear();
                          onSearchChanged('');
                        },
                        icon: const Icon(Icons.clear),
                        tooltip: 'Suche leeren',
                      ),
              ),
              onChanged: onSearchChanged,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<_TaskStatusFilter>(
              key: ValueKey('task-status-$statusFilter'),
              initialValue: statusFilter,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: _TaskStatusFilter.all,
                  child: Text('Alle'),
                ),
                DropdownMenuItem(
                  value: _TaskStatusFilter.open,
                  child: Text('Offen'),
                ),
                DropdownMenuItem(
                  value: _TaskStatusFilter.done,
                  child: Text('Erledigt'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onStatusChanged(value);
                }
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('task-category-${categoryFilter?.name ?? 'all'}'),
              initialValue: categoryFilter?.name ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Kategorie',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final category in BeekeeperTaskCategory.values)
                  DropdownMenuItem(
                    value: category.name,
                    child: Text(category.label),
                  ),
              ],
              onChanged: (value) {
                onCategoryChanged(
                  value == null || value == 'all'
                      ? null
                      : BeekeeperTaskCategory.values.firstWhere(
                          (category) => category.name == value,
                        ),
                );
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              key: ValueKey('task-priority-${priorityFilter?.name ?? 'all'}'),
              initialValue: priorityFilter?.name ?? 'all',
              decoration: const InputDecoration(
                labelText: 'Prioritaet',
                border: OutlineInputBorder(),
              ),
              items: [
                const DropdownMenuItem(value: 'all', child: Text('Alle')),
                for (final priority in BeekeeperTaskPriority.values)
                  DropdownMenuItem(
                    value: priority.name,
                    child: Text(priority.label),
                  ),
              ],
              onChanged: (value) {
                onPriorityChanged(
                  value == null || value == 'all'
                      ? null
                      : BeekeeperTaskPriority.values.firstWhere(
                          (priority) => priority.name == value,
                        ),
                );
              },
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<_TaskDueFilter>(
              key: ValueKey('task-due-$dueFilter'),
              initialValue: dueFilter,
              decoration: const InputDecoration(
                labelText: 'Fälligkeit',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: _TaskDueFilter.all,
                  child: Text('Alle'),
                ),
                DropdownMenuItem(
                  value: _TaskDueFilter.today,
                  child: Text('Heute'),
                ),
                DropdownMenuItem(
                  value: _TaskDueFilter.overdue,
                  child: Text('Überfällig'),
                ),
                DropdownMenuItem(
                  value: _TaskDueFilter.thisWeek,
                  child: Text('Diese Woche'),
                ),
              ],
              onChanged: (value) {
                if (value != null) {
                  onDueChanged(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskListData {
  const _TaskListData({required this.tasks, required this.hives});

  final List<BeekeeperTask> tasks;
  final List<Hive> hives;

  Hive hiveById(String id) {
    return hives.firstWhere((hive) => hive.id == id);
  }
}

class _TaskGroupTitle extends StatelessWidget {
  const _TaskGroupTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium);
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.hive,
    required this.onOpen,
    required this.onComplete,
  });

  final BeekeeperTask task;
  final Hive hive;
  final VoidCallback onOpen;
  final VoidCallback? onComplete;

  @override
  Widget build(BuildContext context) {
    final isOverdue = _isOverdue(task);
    final colorScheme = Theme.of(context).colorScheme;
    final textStyle = task.isOpen
        ? Theme.of(context).textTheme.bodyMedium
        : Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colorScheme.outline);

    return Card(
      color: isOverdue ? AppColors.warningBackground : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: !task.isOpen,
              onChanged: onComplete == null
                  ? null
                  : (_) {
                      debugPrint(
                        'TaskListScreen: checkbox changed for ${task.id}',
                      );
                      onComplete!();
                    },
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: task.isOpen ? null : colorScheme.outline,
                    ),
                  ),
                  if (task.description.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(task.description, style: textStyle),
                  ],
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(label: Text(hive.number)),
                      Chip(label: Text(task.categoryLabel)),
                      Chip(label: Text(task.priorityLabel)),
                      Chip(
                        label: Text(formatDueDate(task.dueDate, task.dueTime)),
                      ),
                      if (isOverdue)
                        const Chip(
                          avatar: Icon(
                            Icons.warning_amber,
                            size: 18,
                            color: Colors.white,
                          ),
                          label: Text('Überfällig'),
                          backgroundColor: AppColors.warningRed,
                          labelStyle: TextStyle(color: Colors.white),
                          side: BorderSide.none,
                        ),
                      if (!task.isOpen && task.completedAt != null)
                        Chip(
                          label: Text(
                            'Erledigt: ${formatDate(task.completedAt)}',
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onOpen,
              icon: const Icon(Icons.edit),
              tooltip: 'Bearbeiten',
            ),
          ],
        ),
      ),
    );
  }

  bool _isOverdue(BeekeeperTask task) {
    if (!task.isOpen) {
      return false;
    }

    final today = DateTime.now();
    final dueDate = DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
    );
    final currentDay = DateTime(today.year, today.month, today.day);
    return dueDate.isBefore(currentDay);
  }
}

extension _TaskCategoryLabel on BeekeeperTaskCategory {
  String get label {
    return switch (this) {
      BeekeeperTaskCategory.inspection => 'Kontrolle',
      BeekeeperTaskCategory.honeySuper => 'Honigraum',
      BeekeeperTaskCategory.beeEscape => 'Bienenflucht',
      BeekeeperTaskCategory.varroa => 'Varroa',
      BeekeeperTaskCategory.feeding => 'Fütterung',
      BeekeeperTaskCategory.queen => 'Königin',
      BeekeeperTaskCategory.other => 'Sonstiges',
    };
  }
}

extension _TaskPriorityLabel on BeekeeperTaskPriority {
  String get label {
    return switch (this) {
      BeekeeperTaskPriority.low => 'Niedrig',
      BeekeeperTaskPriority.normal => 'Normal',
      BeekeeperTaskPriority.high => 'Hoch',
    };
  }
}
