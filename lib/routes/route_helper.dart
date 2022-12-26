import 'package:ecommerceapp/pages/auth/sign_in_page.dart';
import 'package:ecommerceapp/pages/cart/cart_page.dart';
import 'package:ecommerceapp/pages/food/popular_food_detail.dart';
import 'package:ecommerceapp/pages/food/recommended_food_details.dart';
import 'package:ecommerceapp/pages/home/home_page.dart';
import 'package:ecommerceapp/pages/home/main_food_page.dart';
import 'package:ecommerceapp/pages/splash/splash_page.dart';
import 'package:get/route_manager.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";


  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';


  static List<GetPage> routes = [
    GetPage(name: splashPage, page: () => SplashScreen()),
    GetPage(name: "/", page: () => HomePage()),
    GetPage(
      name: signIn,
      page: () {
        return SignInPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: popularFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return PopularFoodDetails(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: recommendedFood,
      page: () {
        var pageId = Get.parameters['pageId'];
        var page = Get.parameters['page'];
        return RecommendedFoodDetails(
          pageId: int.parse(pageId!),
          page: page!,
        );
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: cartPage,
      page: () {
        return CartPage();
      },
      transition: Transition.fadeIn,
    )
  ];
}
