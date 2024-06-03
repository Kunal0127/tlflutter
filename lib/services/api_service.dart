import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tlflutter/app/data/models/product_response_model.dart';

class ApiService extends GetxService {
  // "https://dummyjson.com/products";
  static const baseUrl = 'https://dummyjson.com';

  @override
  void onInit() {
    super.onInit();
    print("ApiService init");
  }

  // ProcuctResponseModel? procuctResponseModel;
  Future<ProcuctResponseModel> fetchProductsAip({
    required int limit,
    required int skip,
    String? category = "",
  }) async {
    try {
      // final response = await http.get(Uri.parse('$baseUrl/products'));
      final response = await http.get(Uri.parse(
              '$baseUrl/products/${category == "" ? "" : "category/$category"}')
          .replace(queryParameters: {
        "limit": limit.toString(),
        "skip": skip.toString()
      }));
      print(response.request);
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return ProcuctResponseModel.fromJson(data);
      } else {
        throw Exception(
            'Failed to load procuct : status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load procuct : $e');
    }
  }

  // ProcuctResponseModel? procuctResponseModel;
  Future<ProcuctResponseModel> searchProductsApi({
    required int limit,
    required int skip,
    String? query = "",
  }) async {
    try {
      // final response = await http.get(Uri.parse('$baseUrl/products'));
      final response = await http.get(Uri.parse('$baseUrl/products/search')
          .replace(queryParameters: {
        "q": query,
        "limit": limit.toString(),
        "skip": skip.toString()
      }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return ProcuctResponseModel.fromJson(data);
      } else {
        throw Exception(
            '(searchProducts) Failed to load procuct : status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('(searchProducts) Failed to load procuct : $e');
    }
  }
}
