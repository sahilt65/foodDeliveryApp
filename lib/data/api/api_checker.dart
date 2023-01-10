import 'package:ecommerceapp/base/show_custom_snack_bar.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:get/get.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(RouteHelper.getSignInPage());
    } else {
      ShowCustomSnackBar(response.statusText!);
    }
  }
}
