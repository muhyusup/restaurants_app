import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant_apps/app/common/style.dart';
import 'package:restaurant_apps/app/modules/search/controller/search_controller.dart';
import 'package:restaurant_apps/app/services/list_items/list_service.dart';
import 'package:restaurant_apps/app/services/search/search_service.dart';

class SearchView extends StatelessWidget {
  final SearchController searchController = Get.put(SearchController(
    searchService: SearchService(),
  ));

  final ListService listService = ListService();

  SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: whiteColor,
              elevation: 0.0,
              pinned: false,
              title: Text(
                'Search',
                style: navbar,
              ),
              iconTheme: const IconThemeData(color: blackColor),
              centerTitle: true,
            )
          ];
        },
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 48,
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(0, 0, 0, 0.1),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.09),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: TextField(
                  onChanged: (value) {
                    searchController.performSearch(value);
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter a search term',
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      icon: SvgPicture.asset("assets/icons/search.svg")),
                ),
              ),
            ),
            Obx(() {
              if (searchController.searchResults.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: searchController.searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      final restaurant = searchController.searchResults[index];
                      return FutureBuilder<Uint8List>(
                          future: listService
                              .getRestaurantImage(restaurant.pictureId),
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                    width: 343,
                                    height: 103,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: whiteColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.09),
                                          offset: Offset(0, 0),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: CircularProgressIndicator(),
                                      ),
                                    )),
                              );
                            } else if (snapshot.hasError) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                    width: 343,
                                    height: 103,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: whiteColor,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.09),
                                          offset: Offset(0, 0),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: const Center(
                                      child: SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Icon(Icons.error),
                                      ),
                                    )),
                              );
                            } else {
                              final imageBytes = snapshot.data;
                              if (imageBytes != null) {
                                return InkWell(
                                  onTap: () {
                                    timeDilation = 5.0;
                                    Get.toNamed('/detail',
                                        arguments: restaurant);
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 6),
                                    child: Container(
                                      width: 343,
                                      height: 103,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: whiteColor,
                                        boxShadow: const [
                                          BoxShadow(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.09),
                                            offset: Offset(0, 0),
                                            blurRadius: 3,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Hero(
                                                tag: imageBytes,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  child: Image.memory(
                                                    imageBytes,
                                                    width: 119,
                                                    height: 87,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 16,
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 7,
                                                ),
                                                Text(
                                                  restaurant.name,
                                                  style: headline6,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      'assets/icons/location.svg',
                                                      width: 16,
                                                      height: 16,
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    Text(
                                                      restaurant.city,
                                                      style: headline7,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      color: yellowColor,
                                                      size: 17,
                                                    ),
                                                    const SizedBox(
                                                      width: 4,
                                                    ),
                                                    Text(
                                                      "${restaurant.rating}",
                                                      style: headline4,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return ListTile(
                                  title: Text(restaurant.name),
                                  subtitle: Text(restaurant.description),
                                );
                              }
                            }
                          }));
                    },
                  ),
                );
              } else if (searchController.isSearchError.value) {
                return Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Column(
                    children: [
                      Image.asset("assets/images/search.png"),
                      Text(
                        "Failed to load restaurant",
                        style: headline5,
                      ),
                      Text(
                        "Please check your internet connection.",
                        style: headline5.copyWith(color: Colors.red),
                      ),
                    ],
                  ),
                );
              } else {
                // Display text when search results are empty
                return Container(
                  margin: const EdgeInsets.only(top: 80),
                  child: Text(
                    "No results found.",
                    style: headline5,
                  ),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
