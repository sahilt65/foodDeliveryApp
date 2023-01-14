import 'package:ecommerceapp/base/custom_button.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage({super.key, required this.orderID, required this.status});

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(PaymentFailedDialog(orderID), barrierDismissible: false);
      });
    }

    return Scaffold(
      body: Center(
          child: SizedBox(
        width: Dimensions.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(status == 1 ? "assets/image/payment_success_image.avif" : "assets/image/payment_failed.png"),
            // SizedBox(
            //   height: Dimensions.height10,
            // ),
            BigText(
              text: status == 1 ? "You placed the order successfully !" : "Order failed \nPlease try again",
              size: 25,
            ),

            SizedBox(
              height: Dimensions.height20,
            ),
            BigText(
              text: status == 1 ? "order ID : $orderID" : "Order failed ",
              size: 25,
            ),
            SizedBox(
              height: Dimensions.height20,
            ),
            Padding(
              padding: EdgeInsets.all(
                Dimensions.height20,
              ),
              child: CustomButton(
                buttonText: "Back to Home",
                onpressed: () => Get.offAllNamed(RouteHelper.getInitial()),
              ),
            )
          ],
        ),
      )),
    );
  }
}
