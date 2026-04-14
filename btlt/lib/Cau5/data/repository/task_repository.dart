import 'dart:convert';
import '../models/task_model.dart';
import '../services/task_api_service.dart';

class TaskRepository {
  final TaskApiService apiService = TaskApiService();

  Future<List<TaskModel>> fetchTasks() async {
    final response = await apiService.getTasks();

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList
          .map((item) => TaskModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception(
      'Failed to load tasks. Status code: ${response.statusCode}',
    );
  }

  Future<void> deleteTask(int id) async {
    final response = await apiService.deleteTask(id);

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception(
        'Failed to delete task. Status code: ${response.statusCode}',
      );
    }
  }
}
