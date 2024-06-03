import 'package:get/get.dart';
import 'package:tlflutter/app/bindings/home_screen_binding.dart';
import 'package:tlflutter/app/bindings/search_result_screen_binding.dart';
import 'package:tlflutter/app/screen/home_screen/home_screen.dart';
import 'package:tlflutter/app/screen/search_result_screen/search_result_screen.dart';

part "app_routes.dart";

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.homeScreen,
      page: () => const HomeScreen(),
      bindings: [HomeScreenBinding()],
    ),
    GetPage(
      name: Routes.searchResultScreen,
      page: () => const SearchResultScreen(),
      bindings: [SearchResultScreenBinding()],
    ),
  ];
}
