// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:ecommerceapp/widgets/icon_and_text_widget.dart';
import 'package:ecommerceapp/widgets/small_text.dart';
import '../utils/dimensions.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BigText(
        text: text,
        size: Dimensions.font26,
      ),
      SizedBox(
        height: Dimensions.height10,
      ),
      Row(
        children: [
          Wrap(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: AppColors.mainColor,
                size: 17,
              ),
            ),
          ),
          SizedBox(width: Dimensions.width10),
          SmallText(text: "4.5"),
          SizedBox(width: Dimensions.width10),
          SmallText(text: "1287"),
          SizedBox(width: Dimensions.width10),
          SmallText(text: "Comments")
        ],
      ),
      SizedBox(height: Dimensions.height20),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1),
          IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor),
          IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "1.7km",
              iconColor: AppColors.iconColor2),
        ],
      )
    ]);
  }
}
