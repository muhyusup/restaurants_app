import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:restaurant_apps/app/models/detail_item/detail_model.dart';
import 'package:restaurant_apps/app/models/list_items/list_model.dart';

class ListService {
  Future<List<ListRestaurant>> getListRestaurant() async {
    final response =
        await http.get(Uri.parse("https://restaurant-api.dicoding.dev/list"));

    if (response.statusCode == 200) {
      final Welcome welcome = Welcome.fromJson(json.decode(response.body));
      return welcome.listrestaurants;
    } else {
      throw Exception('Failed to load restaurants');
    }
  }

  Future<Uint8List> getRestaurantImage(String pictureId) async {
    final response = await http.get(Uri.parse(
        "https://restaurant-api.dicoding.dev/images/small/$pictureId"));

    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load restaurant image');
    }
  }

  Future<Restaurant> getDetailRestaurant(String id) async {
    final String apiUrl = "https://restaurant-api.dicoding.dev/detail/$id";
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final WelcomeD welcomeD = WelcomeD.fromJson(json.decode(response.body));
      return welcomeD.restaurant;
    } else {
      throw Exception("Failed");
    }
  }
}
