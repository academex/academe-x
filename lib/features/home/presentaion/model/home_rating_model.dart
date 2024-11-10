class HomeRatingModel {
  double? _rate;
  int? _count;

  HomeRatingModel({double? rate, int? count}) {
    if (rate != null) {
      this._rate = rate;
    }
    if (count != null) {
      this._count = count;
    }
  }

  double? get rate => _rate;
  set rate(double? rate) => _rate = rate;
  int? get count => _count;
  set count(int? count) => _count = count;

}