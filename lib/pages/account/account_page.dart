import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/account_widget.dart';
import 'package:ecommerceapp/widgets/app_icon.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
          text: "Personal Details",
          color: Colors.white,
        ),
      ),
      body: Container(
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
                      bigText: BigText(text: "Sahil Tiwade"),
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
                      bigText: BigText(text: "9561284971"),
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
                      bigText: BigText(text: "sahiltiwade123@gmail.com"),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //address
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.location_on,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.yellowColor,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 4,
                      ),
                      bigText: BigText(text: "Dhankawadi Pune"),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.message_outlined,
                        iconColor: Colors.white,
                        backgroundColor: Colors.redAccent,
                        iconSize: Dimensions.height10 * 5 / 2,
                        size: Dimensions.height10 * 4,
                      ),
                      bigText: BigText(text: "Sahil"),
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
      ),
    );
  }
}
