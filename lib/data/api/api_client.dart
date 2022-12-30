import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;
  late SharedPreferences sharedPreferences;
  late Map<String, String> _mainHeaders;
  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 60);
    token = "";
    print("sfbifd $token");
    token = sharedPreferences.getString(AppConstants.TOKEN) ?? " ";
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getData(String uri, {Map<String, String>? headers}) async {
    try {
      print("Inside get data");
      print(
        "Uri : " + uri + " headers : " + headers.toString() == null ? _mainHeaders : headers.toString(),
      );
      Response response = await get(
        uri,
        headers: headers ?? _mainHeaders,
      );
      print("Insidetry status code" + response.statusCode.toString());
      print("Inside try body " + response.body.toString());

      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> postData(String uri, dynamic body) async {
    print("Apli Client Body : $body");
    try {
      print(_mainHeaders);
      Response response = await post(
        uri,
        body,
        headers: _mainHeaders,
      );
      print(response.toString());
      print("Inside try : ${response.statusCode}");
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: e.toString());
    }
  }
}
