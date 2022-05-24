import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class RestaurantDataModel{
  final int? id;
  final String? name;
  final List<String>? categories;
  final String? profile_image_url;
  final List<String>? images;
  final List<Operations>? operation_time;
  final String? address;
  final double? rating;

  RestaurantDataModel(
    {
      this.id,
      this.name,
      this.categories,
      this.profile_image_url,
      this.images,
      this.operation_time,
      this.address,
      this.rating
    }
  );

  factory RestaurantDataModel.fromJson(Map<String, dynamic> json){
    return RestaurantDataModel(
      id: json['id'],
      name: json['name'],
      categories: parseCategories(json['categories']),
      profile_image_url: json['profile_image_url'],
      images: parseImages(json['images']),
      operation_time: parseOperations(json),
      address: json['address'],
      rating: json['rating']
    );
  }

  

  static List<String> parseCategories(categoriesJson){
    List<String> categoriesList = new List<String>.from(categoriesJson);
    return categoriesList;
  }

  static List<String> parseImages(imagesJson){
    List<String> imagesList = new List<String>.from(imagesJson);
    return imagesList;
  }

  static List<Operations> parseOperations(operationJson){
    var list = operationJson['operation_time'] as List;
    List<Operations> operationList = list.map((data) => Operations.fromJson(data)).toList();
        
    return operationList;
  }

}

class Operations{
  String? day;
  String? time_open;
  String? time_close;

  Operations({this.day, this.time_open, this.time_close});
  factory Operations.fromJson(Map<String, dynamic> parsedJson){
    return Operations(day: parsedJson['day'], time_open: parsedJson['time_open'], time_close: parsedJson['time_close']);
  }
}

