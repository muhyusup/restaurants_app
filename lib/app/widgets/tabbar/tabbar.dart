import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restaurant_apps/app/common/style.dart';
import 'package:restaurant_apps/app/services/list_items/list_service.dart';
import 'package:restaurant_apps/app/widgets/tabbar/controller.dart';

import '../../models/detail_item/detail_model.dart';

class MyTabbedPage extends StatelessWidget {
  final TabBarController tabBarController = Get.put(TabBarController());

  final ListService listService = ListService();
  final dynamic item = Get.arguments;
  MyTabbedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: whiteColor,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TabBar(
              controller: tabBarController.controller,
              tabs: <Widget>[
                Tab(
                  child: Text(
                    "Drinks",
                    style: textTab,
                  ),
                ),
                Tab(
                  child: Text(
                    "Foods",
                    style: textTab,
                  ),
                ),
              ],
              labelColor: grapeColor,
              unselectedLabelColor: Colors.black,
              indicatorColor: grapeColor,
            ),
            Expanded(
              child: TabBarView(
                controller: tabBarController.controller,
                children: <Widget>[
                  FutureBuilder<Restaurant>(
                    future: listService.getDetailRestaurant(item.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final restaurant = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 163.5 / 165,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            final drink = restaurant.menus.drinks[index];
                            if (restaurant.menus.drinks.isNotEmpty) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Image.asset(
                                        "assets/images/drink.png",
                                        width: double.infinity,
                                        height: 139,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19.25),
                                      child: Text(
                                        drink.name,
                                        style: detail,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Text("ewh data");
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Failed to load detail"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                  FutureBuilder<Restaurant>(
                    future: listService.getDetailRestaurant(item.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final restaurant = snapshot.data!;
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 163.5 / 165,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          itemCount: restaurant.menus.foods.length,
                          itemBuilder: (context, index) {
                            final food = restaurant.menus.foods[index];
                            if (restaurant.menus.foods.isNotEmpty) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.09),
                                      offset: const Offset(0, 1),
                                      blurRadius: 2,
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          topRight: Radius.circular(8)),
                                      child: Image.asset(
                                        "assets/images/food.png",
                                        width: double.infinity,
                                        height: 139,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 19.25),
                                      child: Text(
                                        food.name,
                                        style: detail,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Text("ewh data");
                            }
                          },
                        );
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Text("Failed to load detail"),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
