import 'dart:typed_data';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:restaurant_apps/app/common/style.dart';
import 'package:restaurant_apps/app/models/list_items/list_model.dart';
import 'package:restaurant_apps/app/services/list_items/list_service.dart';

class ListItems extends StatelessWidget {
  final ListService listService = ListService();

  ListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: FutureBuilder<List<ListRestaurant>>(
          future: listService.getListRestaurant(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final listrestaurant = snapshot.data!;
              return ListView.builder(
                itemCount: listrestaurant.length,
                itemBuilder: (context, index) {
                  final listrestaurants = listrestaurant[index];
                  return FutureBuilder<Uint8List>(
                    future: listService
                        .getRestaurantImage(listrestaurants.pictureId),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final imageBytes = snapshot.data!;
                        return InkWell(
                          onTap: () {
                            timeDilation = 5.0;
                            Get.toNamed('/detail', arguments: listrestaurants);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
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
                                          listrestaurants.name,
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
                                              listrestaurants.city,
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
                                              "${listrestaurants.rating}",
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
                      } else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
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
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Icon(Icons.error),
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
                                        listrestaurants.name,
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
                                            listrestaurants.city,
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
                                            "${listrestaurants.rating}",
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
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
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
                      }
                    }),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 100),
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
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
