import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:ecommerceapp/data/api/api_client.dart';
import 'package:ecommerceapp/data/repositary/cart_repo.dart';
import 'package:ecommerceapp/data/repositary/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/controller/popular_product_controller.dart';
import 'package:ecommerceapp/controller/recommended_product_controller.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:ecommerceapp/data/repositary/recommended_product_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repos
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommededProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: Get.find()));

  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
