// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:ecommerceapp/models/cart_model.dart';
import 'package:ecommerceapp/models/popular_products.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/data/repositary/popular_product_repo.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;

  PopularProductController({
    required this.popularProductRepo,
  });

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response responce = await popularProductRepo.getPopularProductList();
    if (responce.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(responce.body).products);
      _isLoaded = true;
      update();
      // print(_popularProductList);
    } else {
      print("You Fucked Up");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQantity(_quantity + 1);
    } else {
      _quantity = checkQantity(_quantity - 1);
    }
    update();
  }

  int checkQantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Item count",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );

      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }

      return 0;
    } else if ((_inCartItems + quantity) > 10) {
      Get.snackbar(
        "Item count",
        "You can't  add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        duration: Duration(seconds: 4),
      );
      return 10;
    } else {
      return quantity;
    }
  }

  void initProduct(ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exists = false;
    exists = cart.existInCart(product);

    print("Exists " + exists.toString());
    if (exists) {
      _inCartItems = _cart.getQuantity(product);
    }
    // print("The quantity in cart is : " + _inCartItems.toString());
    //if exists
    //get from storage
  }

  void addItem(ProductModel product) {
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The id is : " +
          value.id.toString() +
          " The quantity is : " +
          value.quantity.toString());
    });

    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
