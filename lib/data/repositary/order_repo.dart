import 'package:ecommerceapp/data/api/api_client.dart';
import 'package:ecommerceapp/models/place_order_model.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:get/get_connect.dart';

class OrderRepo {
  final ApiClient apiClient;
  OrderRepo({required this.apiClient});

  Future<Response> placeOrder(PlaceOrderBody placeOrderBody) async {
    return await apiClient.postData(AppConstants.PLACE_ORDER_URI, placeOrderBody.toJson());
  }
}
