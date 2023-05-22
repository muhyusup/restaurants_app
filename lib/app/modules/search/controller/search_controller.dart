import 'package:get/get.dart';
import 'package:restaurant_apps/app/models/search/search_model.dart';
import 'package:restaurant_apps/app/services/search/search_service.dart';

class SearchController extends GetxController {
  final SearchService searchService;
  final searchResults = <Restaurant>[].obs;
  final isSearchError = false.obs;

  SearchController({required this.searchService});

  Future<void> performSearch(String searchTerm) async {
    try {
      final results = await searchService.searchAPI(searchTerm);
      searchResults.assignAll(
        results.map((restaurant) => Restaurant.fromJson(restaurant)),
      );
    } catch (e) {
      print(e);
      isSearchError.value = true;
    }
  }
}
