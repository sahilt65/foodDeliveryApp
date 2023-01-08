// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onpressed;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final double? fontSize;
  final double radius;
  final IconData? icon;
  const CustomButton({
    Key? key,
    this.onpressed,
    required this.buttonText,
    this.transparent = false,
    this.margin,
    this.width,
    this.height,
    this.fontSize,
    this.radius = 5,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
        backgroundColor: onpressed == null
            ? Theme.of(context).disabledColor
            : transparent
                ? Colors.transparent
                : AppColors.mainColor,
        minimumSize: Size(width == null ? Dimensions.screenWidth : width!, height != null ? height! : 50),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)));
    return Center(
        child: SizedBox(
      width: width ?? Dimensions.screenWidth,
      height: height ?? 50,
      child: TextButton(
        onPressed: onpressed,
        style: _flatButton,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(right: Dimensions.width10 / 2),
                  child: Icon(icon, color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
                )
              : SizedBox(),
          Text(
            buttonText,
            style: TextStyle(
                fontSize: fontSize ?? Dimensions.font16,
                color: transparent ? Theme.of(context).primaryColor : Theme.of(context).cardColor),
          ),
        ]),
      ),
    ));
  }
}
