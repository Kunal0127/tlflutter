import 'package:get/get.dart';
import 'package:tlflutter/app/controllers/search_result_screen_controller.dart';

class SearchResultScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchResultScreenController());
  }
}
