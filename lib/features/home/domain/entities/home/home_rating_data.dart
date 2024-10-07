import 'package:academe_x/features/home/presentaion/model/home_product_model.dart';
import 'package:academe_x/features/home/presentaion/model/home_rating_model.dart';


class HomeRatingData extends HomeRatingModel{
  HomeRatingData({double? rate, int? count}) {
    this.rate = rate;
    this.count = count;
  }


  HomeRatingData.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rate'] = rate;
    data['count'] = count;
    return data;

  }


}