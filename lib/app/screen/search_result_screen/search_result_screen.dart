import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/controllers/home_screen_controller.dart';
import 'package:tlflutter/app/controllers/search_result_screen_controller.dart';

class SearchResultScreen extends GetView<SearchResultScreenController> {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String q = Get.arguments;
    return Scaffold(
      body: GetBuilder<SearchResultScreenController>(
          init: controller..searchProducts(q),
          builder: (controller) {
            return Column(
              children: [
                ListTile(
                  title: Text("$q"),
                  subtitle: Text(
                      "${controller.productResponseModel?.total ?? 0} Result"),
                  trailing: GestureDetector(
                    onTap: () {
                      controller.toggleProductview();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                      ),
                      child: Icon(Icons.apps),
                      // Obx(
                      //   () => controller.isListview.value == true
                      //       ? Icon(Icons.apps)
                      //       : Icon(Icons.menu),
                      // ),
                    ),
                  ),
                ),
                Expanded(
                  child: Builder(
                    builder: (context) {
                      if (controller.isLoading.value) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return (controller.productResponseModel == null) ||
                                (controller.srList?.isEmpty == true)
                            ? Center(child: Text("Don't have result"))
                            : controller.isListview.value
                                ? ListView.builder(
                                    controller: controller
                                        .searchResultscreenScrollController,
                                    shrinkWrap: true,
                                    // padding: EdgeInsets.symmetric(horizontal: 8.0),
                                    itemCount: controller.srList.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == controller.srList.length) {
                                        if (controller.srList.length !=
                                            controller
                                                .productResponseModel?.total) {
                                          return Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
                                      } else {
                                        return Container(
                                          // width: 50,
                                          height: 120,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Row(
                                            // mainAxisSize: MainAxisSize.min,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl:
                                                    "${controller.srList[index].thumbnail}",
                                                imageBuilder:
                                                    (context, imageProvider) {
                                                  return AspectRatio(
                                                    aspectRatio: 3 / 3.8,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        shape:
                                                            BoxShape.rectangle,
                                                        color: Colors.black12,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        image: DecorationImage(
                                                            image:
                                                                imageProvider),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                placeholder: (context, url) =>
                                                    AspectRatio(
                                                        aspectRatio: 3 / 3.8,
                                                        child: Center(
                                                            child:
                                                                CircularProgressIndicator())),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ).paddingOnly(right: 12),
                                              SizedBox(
                                                width: 280,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        "${controller.srList[index].title}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                        maxLines: 1,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        "${controller.srList[index].description}",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                        ),
                                                        maxLines: 2,
                                                        softWrap: true,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      "\$${controller.srList[index].price}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  )
                                : GridView.builder(
                                    controller: controller
                                        .searchResultscreenScrollController,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 2 / 3,
                                      mainAxisSpacing: 16,
                                      crossAxisSpacing: 16,
                                    ),
                                    itemCount: controller.srList.length + 1,
                                    itemBuilder: (context, index) {
                                      if (index == controller.srList.length) {
                                        if (controller.srList.length !=
                                            controller
                                                .productResponseModel?.total) {
                                          return Padding(
                                            padding: EdgeInsets.all(16),
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );
                                        } else {
                                          return SizedBox.shrink();
                                        }
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
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  "${controller.srList[index].thumbnail}",
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
                                                          BorderRadius.circular(
                                                              12),
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
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                            Text(
                                              "${controller.srList[index].title}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "${controller.srList[index].description}",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                              ),
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "\$${controller.srList[index].price}",
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
            );
          }),
    );
  }
}
