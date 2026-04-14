import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class DashboardApiService {
  Future<http.Response> getUser() async {
    return http.get(
      Uri.parse(AppConstants.userApi),
      headers: {'Accept': 'application/json'},
    );
  }

  Future<http.Response> getPost() async {
    return http.get(
      Uri.parse(AppConstants.postApi),
      headers: {'Accept': 'application/json'},
    );
  }

  Future<http.Response> getProduct() async {
    return http.get(
      Uri.parse(AppConstants.productApi),
      headers: {'Accept': 'application/json'},
    );
  }
}
