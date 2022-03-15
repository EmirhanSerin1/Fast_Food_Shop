class AddressModel {
  String? country;
  String? city;
  String? district;
  String? street;
  String? buildingNumber;
  String? flatNumber;
  String? other;

  AddressModel({
     this.country,
     this.city,
     this.district,
     this.street,
     this.buildingNumber,
     this.flatNumber,
     this.other,
});

  // for send data
  Map<String, dynamic> toMap() {
    return {
      'country': country,
      'city': city,
      'district': district,
      'street': street,
      'buildingNumber': buildingNumber,
      'flatNumber': flatNumber,
      'other': other,
    };
  }

  //For receive data
  factory AddressModel.fromMap(map) {
    return AddressModel(
      country: map['country'],
      city: map['city'],
      district: map['district'],
      street: map['street'],
      buildingNumber: map['buildingNumber'],
      flatNumber: map['flatNumber'],
      other: map['other'],
    );
  }
}
