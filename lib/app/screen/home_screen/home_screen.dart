// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/controllers/home_screen_controller.dart';
import 'package:tlflutter/app/routes/app_pages.dart';
import 'package:tlflutter/app/screen/home_screen/widget/product_filter_bottomsheet.dart';

class HomeScreen extends GetView<HomeScreenController>
    implements PreferredSizeWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductCategory> selectedCategories = [ProductCategory.laptops];
    // ProductCategory selectedCategorie = ProductCategory.laptops;

    void onProductCategorySelected(ProductCategory category) {
      if (selectedCategories.contains(category)) {
        selectedCategories.remove(category);
      } else {
        selectedCategories.add(category);
      }
      // Update UI based on selection changes (optional)
      print("Selected categories: $selectedCategories"); // For demonstration
    }

    // ScrollController scrollController = ScrollController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Flexible(
                  //   child: SearchAnchor.bar(
                  //     barHintText: "Search...",
                  //     barElevation: MaterialStateProperty.all(0),
                  //     isFullScreen: false,
                  //     barBackgroundColor:
                  //         MaterialStatePropertyAll(Colors.black12),
                  //     barLeading: Icon(Icons.search),
                  //     barTrailing: [Icon(Icons.apps)],
                  //     suggestionsBuilder: (context, controller) {
                  //       return [];
                  //     },
                  //   ),
                  // ),
                  Flexible(
                    child: TextField(
                      controller: controller.searchController,
                      onChanged: (value) =>
                          controller.searchQuery.value = value,
                      onTapOutside: (value) {
                        FocusScope.of(context).unfocus();
                      },
                      onSubmitted: (value) {
                        print(value);
                        Get.toNamed(
                          Routes.searchResultScreen,
                          arguments: controller.searchQuery.value,
                        );
                        controller.searchController.clear();
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        hintText: "Search...",
                        prefixIconColor: Colors.grey,
                        suffixIconColor: Colors.grey,
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.send),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32),
                          borderSide: BorderSide.none,
                        ),
                        // enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.all(0),
                        filled: true,
                        fillColor: Colors.black12,
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        ProductFilterBottomSheet(
                          onFilterSelected: controller.productFilterSelected,
                        ).marginAll(8),
                        backgroundColor: Colors.white,
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: Icon(Icons.menu),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Category",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Obx(() {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: ProductCategory.values.map((category) {
                    return ChoiceChip(
                      label: Text(
                        category.name,
                        style: TextStyle(
                            color: category == controller.currentCategory.value
                                ? Colors.white
                                : Colors.grey),
                      ),
                      selected: category == controller.currentCategory.value
                          ? true
                          : false,
                      selectedColor: Colors.black,
                      disabledColor: Colors.grey,
                      onSelected: (value) {
                        print(value);
                        if (value) {
                          controller.changeCategorie(category);
                        }
                      },
                    ).marginOnly(right: 8);
                  }).toList(),
                ),
              );
            }),
            Obx(() {
              return ListTile(
                title: Text("${controller.currentCategory.value.name}"),
                subtitle: Text("${controller.totalProduct} Result"),
                trailing: GestureDetector(
                  onTap: () {
                    controller.toggleView();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black12,
                    ),
                    child: Obx(
                      () => controller.isListview.value == true
                          ? Icon(Icons.apps)
                          : Icon(Icons.menu),
                    ),
                  ),
                ),
              );
            }),
            Expanded(
              child: Obx(
                () {
                  if (controller.isLoading.value) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return (controller.productResponseModel == null) ||
                            (controller
                                    .productResponseModel?.products?.isEmpty ==
                                true)
                        ? Center(child: CircularProgressIndicator())
                        : controller.isListview.value
                            ? ListView.builder(
                                controller:
                                    controller.homescreenScrollController,
                                shrinkWrap: true,
                                // padding: EdgeInsets.symmetric(horizontal: 8.0),
                                itemCount: controller.productList.length + 1,
                                itemBuilder: (context, index) {
                                  // if (index == controller.srList.length) {
                                  //   if (controller.srList.length !=
                                  //       controller
                                  //           .productResponseModel?.total) {
                                  //     return Padding(
                                  //       padding: EdgeInsets.all(16),
                                  //       child: Center(
                                  //           child: CircularProgressIndicator()),
                                  //     );
                                  //   } else {
                                  //     return SizedBox.shrink();
                                  //   }
                                  // }

                                  if (index == controller.productList.length) {
                                    if (controller.productList.length !=
                                        controller
                                            .productResponseModel?.total) {
                                      return Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }

                                    // return Padding(
                                    //   padding: EdgeInsets.all(16),
                                    //   child: Center(
                                    //       child: CircularProgressIndicator()),
                                    // );
                                  }

                                  return Container(
                                    // width: 50,
                                    height: 120,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6.0,
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      // mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${controller.productList[index].thumbnail}",
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return AspectRatio(
                                              aspectRatio: 3 / 3.8,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                      image: imageProvider),
                                                ),
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) =>
                                              AspectRatio(
                                            aspectRatio: 3 / 3.8,
                                            child: Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              AspectRatio(
                                            aspectRatio: 3 / 3.8,
                                            child: Center(
                                              child: Icon(Icons.error),
                                            ),
                                          ),
                                        ).paddingOnly(right: 12),
                                        Flexible(
                                          // width: 280,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${controller.productList[index].title}",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                maxLines: 1,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "${controller.productList[index].description}",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                                ),
                                                maxLines: 2,
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                "\$${controller.productList[index].price}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : GridView.builder(
                                controller:
                                    controller.homescreenScrollController,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 2 / 3,
                                  mainAxisSpacing: 16,
                                  crossAxisSpacing: 16,
                                ),
                                itemCount: controller.productList.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == controller.productList.length) {
                                    if (controller.productList.length !=
                                        controller
                                            .productResponseModel?.total) {
                                      return Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    } else {
                                      return SizedBox.shrink();
                                    }

                                    // return Padding(
                                    //   padding: EdgeInsets.all(16),
                                    //   child: Center(
                                    //       child: CircularProgressIndicator()),
                                    // );
                                  }

                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      // color: Colors.white,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 6.0,
                                          blurStyle: BlurStyle.outer,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl:
                                              "${controller.productList[index].thumbnail}",
                                          imageBuilder:
                                              (context, imageProvider) {
                                            return AspectRatio(
                                              aspectRatio: 1 / 1,
                                              child: Container(
                                                // margin: EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  color: Colors.black12,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  image: DecorationImage(
                                                      image: imageProvider),
                                                ),
                                              ),
                                            );
                                          },
                                          placeholder: (context, url) =>
                                              AspectRatio(
                                                  aspectRatio: 1 / 1,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator())),
                                          errorWidget: (context, url, error) =>
                                              AspectRatio(
                                                  aspectRatio: 1 / 1,
                                                  child: Center(
                                                      child:
                                                          Icon(Icons.error))),
                                        ),
                                        Text(
                                          "${controller.productList[index].title}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "${controller.productList[index].description}",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                          maxLines: 2,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "\$${controller.productList[index].price}",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
