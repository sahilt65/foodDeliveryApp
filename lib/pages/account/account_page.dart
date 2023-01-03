import 'package:ecommerceapp/base/custom_loader.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/controller/cart_controller.dart';
import 'package:ecommerceapp/controller/location_controller.dart';
import 'package:ecommerceapp/controller/user_controller.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/account_widget.dart';
import 'package:ecommerceapp/widgets/app_icon.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool userLoggedIn = Get.find<AuthController>().userLoggedIn();

    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("User has logged in");
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          title: BigText(
            text: "Personal Details",
            color: Colors.white,
          ),
        ),
        body: GetBuilder<UserController>(
          builder: (userController) {
            return userLoggedIn
                ? (userController.isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: Dimensions.height20),
                        width: double.maxFinite,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //profile
                            AppIcon(
                              icon: Icons.person,
                              iconColor: AppColors.mainColor,
                              backgroundColor: Colors.white,
                              iconSize: Dimensions.height15 * 10,
                              size: Dimensions.height15 * 10,
                            ),
                            SizedBox(
                              height: Dimensions.height30,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.person,
                                        iconColor: Colors.white,
                                        backgroundColor: AppColors.mainColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(text: userController.userModel.name),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),

                                    //Mobile Number
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.call,
                                        iconColor: Colors.white,
                                        backgroundColor: AppColors.yellowColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(text: userController.userModel.phone),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //Email
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.mail,
                                        iconColor: Colors.white,
                                        backgroundColor: AppColors.yellowColor,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(text: userController.userModel.email),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //address
                                    GetBuilder<LocationController>(builder: (locationController) {
                                      if (userLoggedIn && locationController.addressList.isEmpty) {
                                        return GestureDetector(
                                      onTap: () {
                                            Get.offNamed(RouteHelper.getAddressPage());
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.location_on,
                                          iconColor: Colors.white,
                                          backgroundColor: AppColors.yellowColor,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 4,
                                        ),
                                            bigText: BigText(text: "Fill in your Address"),
                                      ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            Get.offNamed(RouteHelper.getAddressPage());
                                          },
                                          child: AccountWidget(
                                            appIcon: AppIcon(
                                              icon: Icons.location_on,
                                              iconColor: Colors.white,
                                              backgroundColor: AppColors.yellowColor,
                                              iconSize: Dimensions.height10 * 5 / 2,
                                              size: Dimensions.height10 * 4,
                                            ),
                                            bigText: BigText(text: "Your address"),
                                          ),
                                        );
                                      }
                                    }),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //Message
                                    AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.message_outlined,
                                        iconColor: Colors.white,
                                        backgroundColor: Colors.redAccent,
                                        iconSize: Dimensions.height10 * 5 / 2,
                                        size: Dimensions.height10 * 4,
                                      ),
                                      bigText: BigText(text: "Messages"),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                    //Logout
                                    GestureDetector(
                                      onTap: () {
                                        if (Get.find<AuthController>().userLoggedIn()) {
                                          Get.find<AuthController>().clearSharedData();
                                          Get.find<CartController>().clear();
                                          Get.find<CartController>().clearCartHistory();
                                          Get.offNamed(RouteHelper.getSignInPage());
                                        }
                                      },
                                      child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.logout,
                                          iconColor: Colors.white,
                                          backgroundColor: Colors.redAccent,
                                          iconSize: Dimensions.height10 * 5 / 2,
                                          size: Dimensions.height10 * 4,
                                        ),
                                        bigText: BigText(text: "LogOut"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: Dimensions.height20,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    : CustomLoader())
                : Container(
                    child: Center(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text("Sahil"),
                          width: double.maxFinite,
                          height: Dimensions.height20 * 5,
                          margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('image/signintocontinue.png', package: 'assets'),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getSignInPage());
                          },
                          child: Container(
                            width: double.maxFinite,
                            height: Dimensions.height20 * 5,
                            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                            ),
                            child: Center(
                              child: BigText(
                                text: "Sign in",
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
                  );
          },
        ));
  }
}
