import 'package:ecommerceapp/base/custom_loader.dart';
import 'package:ecommerceapp/base/show_custom_snack_bar.dart';
import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/models/signup_body_mode.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/app_text_field.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/route_helper.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];

    void _registration(AuthController authController) {
      String name = nameController.text.trim(); //trim ignores the spaces
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        ShowCustomSnackBar("Type in your name", title: "Name");
      } else if (phone.isEmpty) {
        ShowCustomSnackBar("Type in your phone number", title: "Phone Number");
      } else if (email.isEmpty) {
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
        ShowCustomSnackBar("You have Registered Succesfully", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success Registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            ShowCustomSnackBar(status.message);
            print(status.message.toString());
            status.printInfo();
          }
        });
        print(signUpBody.toString());
      }
    }

    return Scaffold(body: GetBuilder<AuthController>(
      builder: (_authController) {
        return !_authController.isLoading
            ? SingleChildScrollView(
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
                      height: Dimensions.height20,
                    ),
                    //name
                    AppTextField(
                        textEditingController: nameController,
                        hintText: "Name",
                        icon: Icons.person),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    //Phone
                    AppTextField(
                        textEditingController: phoneController,
                        hintText: "Phone",
                        icon: Icons.phone),
                    SizedBox(
                      height: Dimensions.height45,
                    ),
                    //signup button
                    GestureDetector(
                      onTap: () {
                        _registration(_authController);
                      },
                      child: Container(
                        width: Dimensions.screenWidth / 2,
                        height: Dimensions.screenHeight / 18,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius30),
                        ),
                        child: Center(
                          child: BigText(
                            text: "Sign Up",
                            size: Dimensions.font16 + Dimensions.font16 / 3,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height10,
                    ),

                    RichText(
                      text: TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Get.back(),
                        text: "Have an account already?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16 / 1.4,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.screenHeight * 0.03,
                    ),
                    //Sign up Options
                    RichText(
                      text: TextSpan(
                        text: "Sign up using one of the following account",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimensions.font16 / 1.3,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.height20,
                    ),
                    Wrap(
                      children: List.generate(
                          3,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: Dimensions.radius30 * 0.9,
                                  backgroundImage: AssetImage(
                                      "assets/image/${signUpImages[index]}"),
                                ),
                              )),
                    ),
                  ],
                ),
              )
            : CustomLoader();
      },
    ));
  }
}
