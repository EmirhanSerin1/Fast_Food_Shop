import 'package:flutter/material.dart';

class AddressTextField{
  final _formKey = GlobalKey<FormState>();
  final cityController = TextEditingController();
  final countryController = TextEditingController();
  final streetController = TextEditingController();
  final districtController = TextEditingController();
  final buildingNumberController = TextEditingController();
  final flatNumberController = TextEditingController();
  final otherController = TextEditingController();

   GlobalKey<FormState> get formKey =>_formKey;
}