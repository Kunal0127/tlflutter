import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tlflutter/app/routes/app_pages.dart';
import 'package:tlflutter/services/api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(ApiService());

  runApp(const SafeArea(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TL Flutter',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        textTheme: Typography().black,
        useMaterial3: false,
        bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: Colors.white, modalBackgroundColor: Colors.white),
      ),
      initialRoute: Routes.homeScreen,
      getPages: AppPages.pages,
    );
  }
}
