import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/app_icon.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList();
    Map<String, int> cartItemsPerOrder = Map();

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

//   print(cartItemsPerOrder);
    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<int> orderTimes = cartOrderTimeToList();
    print(orderTimes);

    var listCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.infinity,
            padding: EdgeInsets.only(
              top: 45,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(
                    text: "Cart History",
                    color: Colors.white,
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: 25,
                  ),
                ]),
          ),
          Expanded(
            child: Container(
              color: Colors.red,
              margin: EdgeInsets.only(
                top: Dimensions.height20,
                right: Dimensions.width20,
                left: Dimensions.width20,
              ),
              child: ListView(
                children: [
                  for (int i = 1; i < cartItemsPerOrder.length; i++)
                    Container(
                      margin: EdgeInsets.only(bottom: Dimensions.height20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BigText(text: "06/05/2002"),
                          Row(
                            children: [
                              Wrap(
                                direction: Axis.horizontal,
                                children: List.generate(cartItemsPerOrder[i]!,
                                    (index) {
                                  if (listCounter < getCartHistoryList.length) {
                                    listCounter++;
                                  }
                                  return Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius15 / 2),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              AppConstants.BASE_URL +
                                                  AppConstants.UPLOAD_URL +
                                                  getCartHistoryList[
                                                          listCounter - 1]
                                                      .img!),
                                        )),
                                  );
                                }),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
