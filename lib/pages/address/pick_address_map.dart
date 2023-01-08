import 'package:ecommerceapp/base/custom_button.dart';
import 'package:ecommerceapp/controller/location_controller.dart';
import 'package:ecommerceapp/routes/route_helper.dart';
import 'package:ecommerceapp/utils/colors.dart';
import 'package:ecommerceapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({super.key, required this.fromSignUp, required this.fromAddress, this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initialPosition = LatLng(45.5215638, -122.677433);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initialPosition = LatLng(double.parse(Get.find<LocationController>().getAddress["lattitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));

        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
            child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition) {
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle: () {
                    Get.find<LocationController>().updatePosition(_cameraPosition, false);
                  },
                ),
                Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/image/mark_address.png",
                            height: 40,
                            width: 40,
                          )
                        : CircularProgressIndicator()),
                Positioned(
                  top: Dimensions.height45,
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    height: 50,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor, borderRadius: BorderRadius.circular(Dimensions.radius20 / 2)),
                    child: Row(children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.yellowColor,
                        size: 25,
                      ),
                      Expanded(
                          child: Text(
                        '${locationController.pickPlacemark ?? ''}',
                        style: TextStyle(color: Colors.white, fontSize: Dimensions.font16),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ))
                    ]),
                  ),
                ),
                Positioned(
                    bottom: 75,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    child: locationController.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText: locationController.inZone
                                ? widget.fromAddress
                                    ? 'Pick Address'
                                    : 'Pick Location'
                                : 'Service is not available in your area',
                            onpressed: (locationController.buttonDisabled || locationController.isLoading)
                                ? () {
                                    print("hey ye kya krr diya");
                                  }
                                : () {
                                    if (locationController.pickPosition.longitude != 0 &&
                                        locationController.placemark.name != null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController != null) {
                                          print("Now you can clicked on this");
                                          widget.googleMapController?.moveCamera(CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                  target: LatLng(locationController.pickPosition.latitude,
                                                      locationController.pickPosition.longitude))));

                                          locationController.setAddAddressData();
                                        }
                                        Get.toNamed(RouteHelper.getAddressPage());
                                      }
                                    }
                                  },
                          ))
              ],
            ),
          ),
        )),
      );
    });
  }
}
