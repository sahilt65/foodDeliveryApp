class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String _contactPersonNumber;
  late String _address;
  late String _lattitude;
  late String _longitude;

  AddressModel({
    id,
    required adressType,
    contactPersonName,
    contactPersonNumber,
    address,
    lattitude,
    longitude,
  }) {
    _id = id;
    _addressType = adressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _lattitude = lattitude;
    _longitude = longitude;
  }

  // int? get id => _id;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String get contactPersonNumber => _contactPersonNumber;
  String get address => _address;
  String get lattitude => _lattitude;
  String get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json["id"];
    _addressType = json["address_type"] ?? "";
    _contactPersonNumber = json["contact_person_number"] ?? "";
    _contactPersonName = json["contact_person_name"] ?? "";
    _address = json["address"];
    _lattitude = json["lattitude"];
    _longitude = json["longitute"];
  }
}