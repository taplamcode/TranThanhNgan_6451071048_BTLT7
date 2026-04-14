import 'package:http/http.dart' as http;
import '../../utils/constants.dart';

class ProductApiService {
  Future<http.Response> getProductDetail(int productId) async {
    final url = Uri.parse('${AppConstants.baseUrl}/products/$productId');

    return http.get(url, headers: {'Accept': 'application/json'});
  }
}
