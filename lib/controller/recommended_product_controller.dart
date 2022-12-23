// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceapp/models/popular_products.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:ecommerceapp/data/repositary/recommended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommededProductRepo recommendedProductRepo;

  RecommendedProductController({
    required this.recommendedProductRepo,
  });

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response responce =
        await recommendedProductRepo.getRecommendedProductList();
    if (responce.statusCode == 200) {
      // print("get product recoomended");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(responce.body).products);
      _isLoaded = true;
      update();
      // print(_recommendedProductList);
    } else {
      print("You Fucked Up in recommended");
    }
  }
}
