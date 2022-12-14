import 'dart:convert';
import 'package:ecommerceapp/models/cart_model.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) async {
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    // sharedPreferences.remove(AppConstants.CART_LIST);
    var time = DateTime.now().toString();
    cart = [];
    /*
    convert object to string because sharedpreferences only accepts string
    */

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element.toJson()));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }

  List<CartModel> getCartList() {
    //Just for Debugging purpose

    List<String> carts = [];

    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Inside get Cart List " + carts.toString());
    }

    List<CartModel> cartList = [];

    /*
    List<Object> list = [
      "object1",
      "object2",
      "object3"
    ]
    */
    // carts.forEach((element) {
    //   cartList.add(CartModel.fromJson(jsonDecode(element)));
    // });//Written below was the same

    carts.forEach(
        (element) => cartList.add(CartModel.fromJson(jsonDecode(element))));

    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory = [];
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }

    List<CartModel> cartListHistory = [];
    cartHistory.forEach((element) =>
        cartListHistory.add(CartModel.fromJson(jsonDecode(element))));

    return cartListHistory;
  }

  void addToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("History List" + cart[i]);
      cartHistory.add(cart[i]);
    }
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("The length of List string is : " +
        getCartHistoryList().length.toString());
    for (int i = 0; i < getCartHistoryList().length; i++) {
      print("The time for the order is : " +
          getCartHistoryList()[i].time.toString() +
          "\n");
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }
}
