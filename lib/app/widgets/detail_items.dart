import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:restaurant_apps/app/common/style.dart';
import 'package:restaurant_apps/app/services/list_items/list_service.dart';
import 'package:restaurant_apps/app/widgets/tabbar/tabbar.dart';

class DetailItems extends StatelessWidget {
  final ListService listService = ListService();
  final dynamic item = Get.arguments;

  DetailItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 231,
              backgroundColor: whiteColor,
              flexibleSpace: FutureBuilder<Uint8List>(
                future: listService.getRestaurantImage(item.pictureId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final imageBytes = snapshot.data!;
                    return Hero(
                      tag: item.id,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Failed to load image"),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ];
        },
        body: FutureBuilder<Uint8List>(
          future: listService.getRestaurantImage(item.pictureId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: whiteColor,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.name,
                            style: headline2,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset("assets/icons/location.svg"),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                item.city,
                                style: headline7,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 17,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 17,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 17,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 17,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: yellowColor,
                                    size: 17,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${item.rating}",
                                style: headline4,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item.description,
                            style: headline3,
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: MyTabbedPage()),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to load content"),
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
