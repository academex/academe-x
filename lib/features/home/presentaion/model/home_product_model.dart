
import 'package:academe_x/features/home/presentaion/model/home_rating_model.dart';

class HomeProductModel {
  int? _id;
  String? _title;
  double? _price;
  String? _description;
  String? _category;
  String? _image;
  HomeRatingModel? _rating;

  HomeProductModel(
      {int? id,
        String? title,
        double? price,
        String? description,
        String? category,
        String? image,
        HomeRatingModel? rating}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (price != null) {
      this._price = price;
    }
    if (description != null) {
      this._description = description;
    }
    if (category != null) {
      this._category = category;
    }
    if (image != null) {
      this._image = image;
    }
    if (rating != null) {
      this._rating = rating;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  double? get price => _price;
  set price(double? price) => _price = price;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get category => _category;
  set category(String? category) => _category = category;
  String? get image => _image;
  set image(String? image) => _image = image;
  HomeRatingModel? get rating => _rating;
  set rating(HomeRatingModel? rating) => _rating = rating;

}



