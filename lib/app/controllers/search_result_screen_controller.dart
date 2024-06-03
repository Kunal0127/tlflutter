import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/controllers/home_screen_controller.dart';
import 'package:tlflutter/app/data/providers/product_provider.dart';
import 'package:tlflutter/app/data/models/product_response_model.dart';
import 'package:tlflutter/app/screen/home_screen/widget/product_filter_bottomsheet.dart';

class SearchResultScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isListview = true.obs;
  ScrollController searchResultscreenScrollController = ScrollController();
  // TextEditingController searchController = TextEditingController();
  ProductFilter selectedFilter = ProductFilter.all;

  final ProductProvider _productProvider = ProductProvider();
  ProcuctResponseModel? productResponseModel;
  // search result list
  RxList<Products> srList = <Products>[].obs;

  int perPageProduct = 5;
  late int limit;
  late String searchQuery;
  int skip = 0;

  @override
  void onInit() {
    super.onInit();
    print("Homescreencontroller init");
    limit = perPageProduct;

    // String sq = Get.find<HomeScreenController>().searchController.text.trim();

    // searchProducts(sq: sq);

    searchResultscreenScrollController.addListener(() {
      if (searchResultscreenScrollController.position.maxScrollExtent ==
          searchResultscreenScrollController.offset) {
        print("list reached to end");
        print("limit: $limit skip:$skip");
        // skip = skip + limit;
        // limit = limit + perPageProduct;

        print("limit: $limit skip:$skip");
        print(srList.value.length);
        if (srList.length != productResponseModel?.total) {
          searchProducts(searchQuery);
        }
      }
    });
  }

  @override
  void onClose() {
    searchResultscreenScrollController.dispose();
    super.onClose();
  }

  void searchProducts(String sq) async {
    searchQuery = sq;
    try {
      isLoading(true);

      print("searchProducts called");
      productResponseModel = await _productProvider.searchProcucts(
        limit: limit,
        skip: skip,
        query: sq,
      );

      srList.addAll(productResponseModel?.products as Iterable<Products>);
      // update();
      skip = skip + limit;

      // productList = productResponseModel?.products ?? <Products>[];
      update();
    } catch (e) {
      print("from searchProducts ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

  void productFilterSelected(ProductFilter filter) {
    updateFilter(filter);
    // Implement your product filtering logic based on the selected filter (optional)
    print("Selected filter: $filter");
  }

  void updateFilter(ProductFilter filter) {
    selectedFilter = filter;
    update(); // Inform UI about changes
  }

  void toggleProductview() {
    isListview.value = !isListview.value;
    update();
  }
}
