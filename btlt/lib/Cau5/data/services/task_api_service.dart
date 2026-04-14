import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class TaskApiService {
  Future<http.Response> getTasks() async {
    final url = Uri.parse('${AppConstants.baseUrl}/todos?_limit=20');
    return http.get(url, headers: {'Accept': 'application/json'});
  }

  Future<http.Response> deleteTask(int id) async {
    final url = Uri.parse('${AppConstants.baseUrl}/todos/$id');
    return http.delete(url, headers: {'Accept': 'application/json'});
  }
}
