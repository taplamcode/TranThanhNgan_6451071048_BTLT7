import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../data/repository/task_repository.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskRepository repository = TaskRepository();
  List<TaskModel> tasks = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await repository.fetchTasks();
      if (!mounted) {
        return;
      }
      setState(() {
        tasks = data;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      if (!mounted) {
        return;
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteTask(TaskModel task, int index) async {
    final removedTask = task;

    setState(() {
      tasks.removeAt(index);
    });

    try {
      await repository.deleteTask(task.id);

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Da xoa task #${task.id}')));
    } catch (e) {
      if (!mounted) {
        return;
      }

      setState(() {
        tasks.insert(index, removedTask);
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Xoa task that bai: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(onPressed: loadTasks, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Khong the tai danh sach task: $errorMessage',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: loadTasks,
                      child: const Text('Thu lai'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (tasks.isEmpty) {
            return const Center(child: Text('Khong con task nao'));
          }

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return Dismissible(
                key: ValueKey(task.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => deleteTask(task, index),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.completed ? 'Completed' : 'Pending'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => deleteTask(task, index),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
