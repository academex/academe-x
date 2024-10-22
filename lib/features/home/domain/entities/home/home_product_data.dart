// import 'package:academe_x/features/home/presentaion/model/home_product_model.dart';
//
// import 'home_rating_data.dart';
//
//
// class HomeProductData extends HomeProductModel{
//
//
//   HomeProductData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     title = json['title'];
//     price = json['price'];
//     description = json['description'];
//     category = json['category'];
//   image = json['image'];
//   rating =
//     json['rating'] != null ? HomeRatingData.fromJson(json['rating']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = id;
//     data['title'] = title;
//     data['price'] = price;
//     data['description'] = description;
//     data['category'] = category;
//     data['image'] = image;
//     if (rating != null) {
//       data['rating'] = HomeRatingData().toJson();
//     }
//     return data;
//   }
//
//
// }