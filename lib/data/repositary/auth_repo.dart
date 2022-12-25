// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceapp/models/signup_body_mode.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommerceapp/data/api/api_client.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuthRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> registration(SignUpBody signUpBody) async {
    // print(signUpBody.toJson());
    return await apiClient.postData(
        AppConstants.REGISTRATION_URI, signUpBody.toJson());
  }

  Future<String> getUserToken() async {
    print("Token : " + sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.getString(AppConstants.TOKEN) ?? "None";
  }

  Future<Response> login(String email, String password) async {
    // print(signUpBody.toJson());
    print("Inside Auth Repo :" + email + " " + password);
    return await apiClient.postData(
        AppConstants.LOGIN_URI, {"email": email, "password": password});
  }

  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;

    apiClient.updateHeader(token);
    // print("token" + token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  Future<void> saveUserNumberAndPassword(String number, String password) async {
    try {
      await sharedPreferences.setString(AppConstants.PHONE, number);
      await sharedPreferences.setString(AppConstants.PASSWORD, password);
    } catch (e) {
      throw e;
    }
  }
}
