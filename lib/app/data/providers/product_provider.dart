import 'package:get/get.dart';
import 'package:tlflutter/app/data/models/product_response_model.dart';
import 'package:tlflutter/services/api_service.dart';

class ProductProvider {
  final ApiService _apiService = Get.find<ApiService>();

  Future<ProcuctResponseModel> getProcucts(
      {required int limit, required int skip, String? category = ""}) async {
    return _apiService.fetchProductsAip(
        limit: limit, skip: skip, category: category);
  }

  Future<ProcuctResponseModel> searchProcucts(
      {required int limit, required int skip, String? query = ""}) async {
    return _apiService.searchProductsApi(
        limit: limit, skip: skip, query: query);
  }
}
