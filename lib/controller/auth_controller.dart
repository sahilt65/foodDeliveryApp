// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceapp/models/response_model.dart';
import 'package:ecommerceapp/models/signup_body_mode.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:ecommerceapp/data/repositary/auth_repo.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  _registration(SignUpBody signUpBody) async {
    _isLoading = true;

    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = true;
    update();
    return responseModel;
  }
}
