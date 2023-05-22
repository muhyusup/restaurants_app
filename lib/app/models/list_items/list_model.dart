import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool error;
  String message;
  int count;
  List<ListRestaurant> listrestaurants;

  Welcome({
    required this.error,
    required this.message,
    required this.count,
    required this.listrestaurants,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        listrestaurants: List<ListRestaurant>.from(
            json["restaurants"].map((x) => ListRestaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants":
            List<dynamic>.from(listrestaurants.map((x) => x.toJson())),
      };
}

class ListRestaurant {
  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  ListRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
      };
}
