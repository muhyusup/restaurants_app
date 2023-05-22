import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant_apps/app/common/style.dart';
import 'package:restaurant_apps/app/widgets/list_items.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 0.0,
              pinned: false, // Set pinned to false to make the AppBar non-fixed
              title: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 50,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hai selamat siang",
                      style: headline7,
                    ),
                    Text(
                      "Dyana Saputri",
                      style: headline1,
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/search.svg",
                  ),
                  onPressed: () {
                    Get.toNamed('/search');
                  },
                ),
              ],
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: ListItems(),
        ),
      ),
    );
  }
}
