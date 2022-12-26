import 'package:ecommerceapp/base/show_custom_snack_bar.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/pages/auth/sign_up_page.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/app_text_field.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        ShowCustomSnackBar("Type in your Email addresss",
            title: "Email Addresss");
      } else if (!GetUtils.isEmail(email)) {
        ShowCustomSnackBar("Type in a valid Email addresss",
            title: "Valid Email addresss");
      } else if (password.isEmpty) {
        ShowCustomSnackBar("Type in your Password", title: "password");
      } else if (password.length < 6) {
        ShowCustomSnackBar("Pass word can't be less than siz character",
            title: "password");
      } else {
        ShowCustomSnackBar("Perfect", title: "Perfect");
        print(email + " Pass : " + password);
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            print("Success Login");
            Get.toNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);

          }
        });
        // print(signUpBody.toString());
      }
    }

    return Scaffold(body: GetBuilder<AuthController>(
      builder: (authController) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              //logo
              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),
              Container(
                height: Dimensions.screenHeight * 0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white24,
                    radius: Dimensions.radius20 * 4,
                    backgroundImage: AssetImage(
                      "assets/image/logo.png",
                    ),
                  ),
                ),
              ),

              //Welcome

              Container(
                width: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20 * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.01,
                    ),
                    Text(
                      "Sign in to your account",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ),

              SizedBox(
                height: Dimensions.screenHeight * 0.05,
              ),

              //Email
              AppTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.mail),
              SizedBox(
                height: Dimensions.height20,
              ),
              //Password
              AppTextField(
                textEditingController: passwordController,
                hintText: "Passsword",
                icon: Icons.key,
                isObscure: true,
              ),
              SizedBox(
                height: Dimensions.height20 * 2,
              ),

              //signin button
              GestureDetector(
                onTap: () {
                  _login(authController);
                },
                child: Container(
                  width: Dimensions.screenWidth / 2,
                  height: Dimensions.screenHeight / 18,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign in",
                      size: Dimensions.font16 + Dimensions.font16 / 3,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10 * 2,
              ),
              //Dont have Account
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.back(),
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: Dimensions.font16 / 1.4,
                    ),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.to(() => SignUpPage(),
                                transition: Transition.leftToRightWithFade),
                          text: " Create",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.font16 / 1.4,
                              fontWeight: FontWeight.bold))
                    ]),
              ),
            ],
          ),
        );
      },
    ));
  }
}
