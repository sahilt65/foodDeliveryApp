import 'package:ecommerceapp/models/address_model.dart';
import 'package:ecommerceapp/utils/app_constants.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecommerceapp/data/api/api_client.dart';

class LocationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

  Future<Response> getAddressfromGeocode(LatLng latLng) async {
    print(latLng.latitude.toString() + " ehy : " + latLng.longitude.toString());
    print('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
    return await apiClient.getData('${AppConstants.GEOCODE_URI}'
        '?lat=${latLng.latitude}&lng=${latLng.longitude}');
  }

  String getUserAddress() {
    return sharedPreferences.getString(AppConstants.USER_ADDRESS) ?? "";
  }

  Future<Response> addAddress(AddressModel addressModel) async {
    return await apiClient.postData(AppConstants.ADD_USER_ADDRESS, addressModel.toJson());
  }

  Future<Response> getAllAddress() async {
    return await apiClient.getData(AppConstants.ADDRESS_LIST_URI);
  }

  Future<bool> saveUseraddress(String address) async {
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    return await sharedPreferences.setString(AppConstants.USER_ADDRESS, address);
  }

  Future<Response> getZone(String lat, String lng) async {
    return await apiClient.getData('${AppConstants.ZONE_URI}?&lat=$lat&lng=$lng');
  }

  Future<Response> searchLocation(String text) async {
    return await apiClient.getData('${AppConstants.SEARCH_LOCATION_URI}?search_text=$text');
  }

  Future<Response> setLocation(String placeId) async {
    return await apiClient.getData('${AppConstants.PLACE_DETAILS_URI}?placeid=$placeId');
  }
}
