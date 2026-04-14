class TaskModel {
  final int id;
  final String title;
  final bool completed;

  TaskModel({required this.id, required this.title, required this.completed});

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] ?? '').toString(),
      completed: json['completed'] == true,
    );
  }
}
