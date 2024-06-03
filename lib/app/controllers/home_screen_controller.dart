import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/data/providers/product_provider.dart';
import 'package:tlflutter/app/data/models/product_response_model.dart';
import 'package:tlflutter/app/screen/home_screen/widget/product_filter_bottomsheet.dart';

class HomeScreenController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isProductLoading = false.obs;

  RxBool isListview = true.obs;
  ScrollController homescreenScrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  ProductFilter selectedFilter = ProductFilter.all;
  final ProductProvider _productProvider = ProductProvider();
  ProcuctResponseModel? productResponseModel;
  RxList<Products> productList = <Products>[].obs;
  RxInt totalProduct = 0.obs;

  RxString searchQuery = ''.obs;

  Rx<ProductCategory> currentCategory = ProductCategory.all.obs;

  int perPageProduct = 5;
  late int limit;
  int skip = 0;

  @override
  void onInit() {
    super.onInit();
    print("Homescreencontroller init");
    limit = perPageProduct;
    isLoading(true);
    fetchProducts();
    isLoading(false);

    homescreenScrollController.addListener(() {
      if (homescreenScrollController.position.maxScrollExtent ==
          homescreenScrollController.offset) {
        print("list reached to end");
        print("limit: $limit skip:$skip");
        // skip = skip + limit;
        // limit = limit + perPageProduct;

        print("limit: $limit skip:$skip");
        print(productList.value.length);

        if (productList.length != productResponseModel?.total) {
          fetchProducts(
              category: currentCategory == ProductCategory.all
                  ? ""
                  : productCategorys[currentCategory.value]);
        }
      }
    });
  }

  @override
  void onClose() {
    homescreenScrollController.dispose();
    super.onClose();
  }

  void fetchProducts({String? category = ""}) async {
    try {
      isProductLoading(true);
      print("fetchProducts called");
      productResponseModel = await _productProvider.getProcucts(
          limit: limit, skip: skip, category: category);
      totalProduct.value = productResponseModel?.total ?? 0;
      productList.addAll(productResponseModel?.products as Iterable<Products>);
      // update();
      skip = skip + limit;

      // productList = productResponseModel?.products ?? <Products>[];
      update();
    } finally {
      isProductLoading(false);
    }
  }

  void searchProducts() async {
    try {
      isLoading(true);
      print("searchProducts called");
      productResponseModel = await _productProvider.searchProcucts(
        limit: limit,
        skip: skip,
        query: searchController.text.trim(),
      );

      productList.addAll(productResponseModel?.products as Iterable<Products>);
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

  void toggleView() {
    isListview.value = !isListview.value;
    update();
  }

  void changeCategorie(ProductCategory category) {
    skip = 0;
    print(productList.length);
    productList.value.clear();
    print(productList.length);
    update();
    currentCategory.value = category;
    fetchProducts(category: productCategorys[category]);
    update();
  }
}
