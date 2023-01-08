// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:ecommerceapp/models/address_model.dart';
import 'package:ecommerceapp/models/response_model.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:ecommerceapp/data/repositary/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;
  LocationController({
    required this.locationRepo,
  });

  bool _loading = false;
  late Position _position;
  late Position _pickPosition;
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();
  List<AddressModel> _addressList = [];
  late List<AddressModel> _allAddressList = [];
  List<String> _addressTypelist = ["home", "office", "others"];

  bool _isLoading = false; //For Service Zone
  bool get isLoading => _isLoading;
  bool _inZone = false; //Whether the user is in service zone or not
  bool get inZone => _inZone;
  bool _buttonDisabled = true; //showing and hiding the button as map loads
  bool get buttonDisabled => _buttonDisabled;

  int _addressTypeIndex = 0;

  late GoogleMapController _mapController;
  List<AddressModel> get addressList => _addressList;
  List<AddressModel> get allAddressList => _allAddressList;
  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickPosition;
  Placemark get placemark => _placemark;
  Placemark get pickPlacemark => _pickPlacemark;
  List<String> get addressTypeList => _addressTypelist;
  int get addressTypeIndex => _addressTypeIndex;
  GoogleMapController get mapController => _mapController;
  bool _updateAddressData = true;
  bool _changeAddress = true;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    print("Update Position");
    if (_updateAddressData) {
      print("object");
      _loading = true;
      update();
      try {
        if (fromAddress) {
          print("Inside try");
          _position = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        } else {
          _pickPosition = Position(
            latitude: position.target.latitude,
            longitude: position.target.longitude,
            timestamp: DateTime.now(),
            heading: 1,
            accuracy: 1,
            altitude: 1,
            speedAccuracy: 1,
            speed: 1,
          );
        }

        ResponseModel _responseModel =
            await getZone(position.target.latitude.toString(), position.target.longitude.toString(), false);
        /*
            if button value is false we are in the service area
            */
        _buttonDisabled = !_responseModel.isSuccess;
        if (_changeAddress) {
          print("${position.target.latitude}longitude${position.target.longitude}");
          String _address = await getAddressfromGeocode(LatLng(
            position.target.latitude,
            position.target.longitude,
          ));
          print("hfbdrgber : " + _address);
          fromAddress ? _placemark = Placemark(name: _address) : _pickPlacemark = Placemark(name: _address);
        }
      } catch (e) {
        print(e);
      }
      _loading = false;
      update();
    } else {
      _updateAddressData = true;
    }
  }

  Future<String> getAddressfromGeocode(LatLng latLng) async {
    String _address = "Unknown Location Found";

    Response response = await locationRepo.getAddressfromGeocode(latLng);
    print("Status Code : ${response.statusCode}");
    print(response.body);
    if (response.body["status"] == "OK") {
      _address = response.body["result"][0]['formatted_address'].toString();
      print("Printing Address : $_address");
    } else {
      print("Error getting the google api");
    }
    print("Address : $_address");
    return _address;
  }

  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  getUserAddress() {
    late AddressModel _addressModel;
    /*
    Converting to map using jsonDecode
    */
    _getAddress = jsonDecode(locationRepo.getUserAddress());

    try {
      _addressModel = AddressModel.fromJson(jsonDecode(locationRepo.getUserAddress()));
    } catch (e) {
      print(e);
    }
  }

  setAddressTypeIndex(int index) {
    _addressTypeIndex = index;
    update();
  }

  Future<ResponseModel> addAddress(AddressModel addressModel) async {
    _loading = true;
    update();
    Response response = await locationRepo.addAddress(addressModel);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      await getAddressList();
      String message = response.body["message"];
      responseModel = ResponseModel(true, message);
      await saveUserAddress(addressModel);
    } else {
      print("couldn't save the address");
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();

    return responseModel;
  }

  getAddressList() async {
    Response response = await locationRepo.getAllAddress();

    if (response.statusCode == 200) {
      _allAddressList = [];
      _addressList = [];
      response.body.foEach((address) {
        _addressList.add(AddressModel.fromJson(address));
        _allAddressList.add(AddressModel.fromJson(address));
      });
    } else {
      _addressList = [];
      _allAddressList = [];
    }
  }

  Future<bool> saveUserAddress(AddressModel addressModel) async {
    String userAddress = jsonEncode(addressModel.toJson());
    return await locationRepo.saveUseraddress(userAddress);
  }

  getUserAddressFromLocalStorage() {
    return locationRepo.getUserAddress();
  }

  setAddAddressData() {
    _position = _pickPosition;
    _placemark = _pickPlacemark;
    _updateAddressData = false;
    update();
  }

  Future<ResponseModel> getZone(String lat, String lng, bool markerLoad) async {
    late ResponseModel _responseModel;
    if (markerLoad) {
      _loading = true;
    } else {
      _isLoading = true;
    }

    update();
    Response response = (await locationRepo.getZone(lat, lng));
    if (response.statusCode == 200) {
      _inZone = true;
      _responseModel = ResponseModel(true, response.body["zone-id"].toString());
    } else {
      _inZone = false;
      _responseModel = ResponseModel(true, response.statusText!);
    }
    if (markerLoad) {
      _loading = false;
    } else {
      _isLoading = false;
    }
    print("Zone Response code is : " + response.statusCode.toString());
    update();
    return _responseModel;
  }
}
