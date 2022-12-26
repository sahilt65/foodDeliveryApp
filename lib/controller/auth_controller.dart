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

  Future<ResponseModel> registration(SignUpBody signUpBody) async {
    print("Getting token");
    authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel responseModel;
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print("Hello");
      authRepo.saveUserToken(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
    } else {
      print("Nikal bsdk");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String email, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(email, password);
    print("Response in auth controller : $response");
    late ResponseModel responseModel;
    print("Status Cod ein controller : ${response.statusCode}");
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      print("Hello");
      authRepo.saveUserToken(response.body["token"]);
      print(response.body["token"]);
      responseModel = ResponseModel(true, response.body["token"]);
      
    } else {
      print("Nikal bsdk");
      responseModel = ResponseModel(false, response.statusText!);
    }

    _isLoading = false;
    update();
    return responseModel;
  }

  void saveUserNumberAndPassword(String number, String password) async {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }
}
