import 'dart:convert';

class RestaurantListApi {
    RestaurantListApi({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<RestaurantList> restaurants;

    factory RestaurantListApi.fromJson(Map<String, dynamic> json) => RestaurantListApi(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class Search {
    Search({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<RestaurantList> restaurants;

    factory Search.fromJson(Map<String, dynamic> json) => Search(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantList {
    RestaurantList({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(  
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
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

class RestaurantApi {
    RestaurantApi({
        required this.error,
        required this.message,
        required this.restaurant,
    });

    bool error;
    String message;
    Restaurant restaurant;

    factory RestaurantApi.fromJson(Map<String, dynamic> json) => RestaurantApi(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}

class Restaurant {
    Restaurant({
        required this.id,
        required this.name,
        required this.description,
        required this.city,
        required this.address,
        required this.pictureId,
        required this.categories,
        required this.menus,
        required this.rating,
        required this.customerReviews,
    });

    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    List<Category> categories;
    Menus menus;
    double rating;
    List<CustomerReview> customerReviews;

    factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        required this.name,
    });

    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class CustomerReview {
    CustomerReview({
        required this.name,
        required this.review,
        required this.date,
    });

    String name;
    String review;
    String date;

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}

class Menus {
    Menus({
        required this.foods,
        required this.drinks,
    });

    List<Category> foods;
    List<Category> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
    Review({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    bool error;
    String message;
    List<AddReview> customerReviews;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        error: json["error"],
        message: json["message"],
        customerReviews: List<AddReview>.from(json["customerReviews"].map((x) => AddReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class AddReview {
    AddReview({
        required this.name,
        required this.review,
        required this.date,
    });

    String name;
    String review;
    String date;

    factory AddReview.fromJson(Map<String, dynamic> json) => AddReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}



