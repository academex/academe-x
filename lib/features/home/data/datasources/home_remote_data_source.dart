import 'package:academe_x/features/home/domain/entities/home/home_product_data.dart';
import 'package:academe_x/features/home/presentaion/model/home_product_model.dart';
import '../../../../core/network/api_controller.dart';
import '../../../../core/network/api_setting.dart';

class HomeRemoteDataSource {
  final ApiController apiController;

  HomeRemoteDataSource({required this.apiController});

  Future<List<HomeProductModel>> getProducts() async {
    try {
      final response = await apiController.get(
        isRefresh: true,
        Uri.parse(ApiSetting.productsHome),
        headers: {
          'Content-Type': 'application/json'
        },
        timeToLive: 60 * 60 * 24,
      );
      return response as List<HomeProductModel>;
    } catch (e) {
      // Logger().e(e);
      rethrow;
    }
  }

}