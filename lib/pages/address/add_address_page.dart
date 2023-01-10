import 'package:ecommerceapp/controller/auth_controller.dart';
import 'package:ecommerceapp/controller/location_controller.dart';
import 'package:ecommerceapp/controller/popular_product_controller.dart';
import 'package:ecommerceapp/controller/user_controller.dart';
import 'package:ecommerceapp/models/address_model.dart';
import 'package:ecommerceapp/pages/address/pick_address_map.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:ecommerceapp/widgets/app_icon.dart';
import 'package:ecommerceapp/widgets/app_text_field.dart';
import 'package:ecommerceapp/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPage();
}

class _AddAddressPage extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  late bool _isLoagged = true;
  CameraPosition _cameraPosition = const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);

  LatLng _initialPosition = const LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLoagged = Get.find<AuthController>().userLoggedIn();
    if (_isLoagged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() == "") {
        Get.find<LocationController>().saveUserAddress(
          Get.find<LocationController>().addressList.last,
        );
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
        double.parse(Get.find<LocationController>().getAddress["latitude"]),
        double.parse(Get.find<LocationController>().getAddress["longitude"]),
      ));

      _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Page"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          if (_contactPersonName.text.isEmpty) {
            _contactPersonName.text = userController.userModel.name;
            _contactPersonNumber.text = userController.userModel.phone;
            /*Check This I dont know why this statement is causing error */
            // if (Get.find<LocationController>().addressList.isNotEmpty) {
            //   _addressController.text = Get.find<LocationController>().getUserAddress().address;
            // }
          }
          return GetBuilder<LocationController>(
            builder: (locationController) {
              _addressController.text = '${locationController.placemark.name ?? ''}'
                  '${locationController.placemark.locality ?? ''}'
                  '${locationController.placemark.postalCode ?? ''}'
                  '${locationController.placemark.country ?? ''}';
              print("Address in y view is : ${_addressController.text}");
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5, top: 5),
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 2, color: AppColors.mainColor)),
                      child: Stack(
                        children: [
                          GoogleMap(
                            onTap: (latLng) {
                              Get.toNamed(RouteHelper.getPickAddressPage(),
                                  arguments: PickAddressMap(
                                    fromSignUp: false,
                                    fromAddress: true,
                                    googleMapController: locationController.mapController,
                                  ));
                            },
                            initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                            zoomControlsEnabled: false,
                            compassEnabled: false,
                            indoorViewEnabled: true,
                            mapToolbarEnabled: false,
                            myLocationEnabled: true,
                            onCameraIdle: () {
                              locationController.updatePosition(_cameraPosition, true);
                            },
                            onCameraMove: ((position) => _cameraPosition = position),
                            onMapCreated: (GoogleMapController controller) {
                              locationController.setMapController(controller);
                            },
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20, top: Dimensions.height15),
                      child: SizedBox(
                        height: Dimensions.height10 * 5,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: locationController.addressTypeList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  locationController.setAddressTypeIndex(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Dimensions.width20, vertical: Dimensions.height10),
                                  margin: EdgeInsets.only(right: Dimensions.width10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20 / 4),
                                      color: Theme.of(context).cardColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey[200]!,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        )
                                      ]),
                                  child: Icon(
                                    index == 0
                                        ? Icons.home_filled
                                        : index == 1
                                            ? Icons.work
                                            : Icons.location_on,
                                    color: locationController.addressTypeIndex == index
                                        ? AppColors.mainColor
                                        : Theme.of(context).disabledColor,
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Delivery Address"),
                    ),
                    SizedBox(height: Dimensions.height20),
                    AppTextField(textEditingController: _addressController, hintText: "Your Address", icon: Icons.map),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Contact Name"),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(textEditingController: _contactPersonName, hintText: "Your Name", icon: Icons.person),
                    SizedBox(height: Dimensions.height20),
                    Padding(
                      padding: EdgeInsets.only(left: Dimensions.width20),
                      child: BigText(text: "Contact Number"),
                    ),
                    SizedBox(height: Dimensions.height10),
                    AppTextField(
                        textEditingController: _contactPersonNumber, hintText: "Your Phone Number", icon: Icons.phone),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: Dimensions.bottomHeightBar,
                padding: EdgeInsets.only(
                  top: Dimensions.height20,
                  bottom: Dimensions.height20,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20 * 2),
                      topRight: Radius.circular(Dimensions.radius20 * 2),
                    ),
                    color: AppColors.buttonBackgroundColor),
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  GestureDetector(
                    onTap: () {
                      AddressModel addressModel = AddressModel(
                        adressType: locationController.addressTypeList[locationController.addressTypeIndex],
                        contactPersonName: _contactPersonName.text,
                        contactPersonNumber: _contactPersonNumber.text,
                        address: _addressController.text,
                        latitude: locationController.position.latitude.toString(),
                        longitude: locationController.position.longitude.toString(),
                      );
                      print("Sahil you did it ${addressModel.toString}");
                      locationController.addAddress(addressModel).then((response) {
                        if (response.isSuccess) {
                          print("Sahil you did it ");
                          Get.toNamed(RouteHelper.getInitial());
                          Get.snackbar("Address", "Added Successfully");
                        } else {
                          Get.snackbar("Address", "Couldn't Saved");
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.height20,
                          bottom: Dimensions.height20,
                          left: Dimensions.width20,
                          right: Dimensions.width20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                      child: BigText(
                        text: "Save Address",
                        color: Colors.white,
                      ),
                    ),
                  )
                ]),
              ),
            ],
          );
        },
      ),
    );
  }
}
