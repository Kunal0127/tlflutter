import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/controllers/home_screen_controller.dart';

enum ProductFilter {
  all,
  accending,
  decending,
  relveance,
  popularity,
  newestFirst,
  priceLowToHigh,
  priceHighToLow
}

enum ProductCategory {
  all,
  smartphones,
  laptops,
  homeDecoration,
  groceries,
  fragrances,
  skincare,
  beauty,
}

Map<ProductCategory, String> productCategorys = {
  ProductCategory.all: "",
  ProductCategory.smartphones: "smartphones",
  ProductCategory.laptops: "laptops",
  ProductCategory.homeDecoration: "home-decoration",
  ProductCategory.groceries: "groceries",
  ProductCategory.fragrances: "fragrances",
  ProductCategory.skincare: "skin-care",
  ProductCategory.beauty: "beauty",
};

class ProductFilterBottomSheet extends GetView<HomeScreenController> {
  final Function(ProductFilter) onFilterSelected;

  const ProductFilterBottomSheet({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sort By",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              TextButton(
                  onPressed: () => onFilterSelected(ProductFilter.all),
                  child: Text("Clear")),
            ],
          ),
          Divider(),
          RadioListTile(
            title: "Acending - Decending",
            value: ProductFilter.accending,
            onFilterSelected: onFilterSelected,
          ),
          RadioListTile(
            title: "Relveance",
            value: ProductFilter.relveance,
            onFilterSelected: onFilterSelected,
          ),
          RadioListTile(
            title: "Newest First",
            value: ProductFilter.newestFirst,
            onFilterSelected: onFilterSelected,
          ),
          RadioListTile(
            title: "Popularity",
            value: ProductFilter.popularity,
            onFilterSelected: onFilterSelected,
          ),
          RadioListTile(
            title: "Price - High to Low",
            value: ProductFilter.priceHighToLow,
            onFilterSelected: onFilterSelected,
          ),
          RadioListTile(
            title: "Price - Low to High",
            value: ProductFilter.priceLowToHigh,
            onFilterSelected: onFilterSelected,
          ),
        ],
      ),
    );
  }
}

class RadioListTile extends GetView<HomeScreenController> {
  final String title;
  final ProductFilter value;
  final Function(ProductFilter)? onFilterSelected;

  const RadioListTile({
    super.key,
    required this.title,
    required this.value,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Get.back();
        onFilterSelected!(value);
      },
      child: Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("$title"),
            Radio<ProductFilter>(
              value: value,
              groupValue: controller.selectedFilter ?? ProductFilter.all,
              activeColor: Colors.black,
              onChanged: (value) => onFilterSelected!(value!),
            )
          ],
        ),
      ),
    );
  }
}
