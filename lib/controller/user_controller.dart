import 'package:ecommerceapp/data/repositary/user_repo.dart';
import 'package:ecommerceapp/models/response_model.dart';
import 'package:ecommerceapp/models/user_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = true;
  late UserModel _userModel = UserModel(id: 1, name: "Sahil", email: "c@c.com", phone: "12345", orderCount: 1);
  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo();
    late ResponseModel responseModel;
    print("Hey" + response.statusCode.toString());
    if (response.statusCode == 200) {
      print("User Model");
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}
