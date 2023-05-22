import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:restaurant_apps/app/modules/home/home_page.dart';

import 'package:restaurant_apps/app/modules/search/search_page.dart';
import 'package:restaurant_apps/app/widgets/detail_items.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant Search',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => const HomePage()),
        GetPage(name: '/search', page: () => SearchView()),
        GetPage(name: '/detail', page: () => DetailItems()),
      ],
    );
  }
}
