import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../api/api_client.dart';

class RecommededProductRepo extends GetxService {
  final ApiClient apiClient;
  RecommededProductRepo({
    required this.apiClient,
  });

  Future<Response> getRecommendedProductList() async {
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
