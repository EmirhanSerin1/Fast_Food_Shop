import 'package:flutter/widgets.dart';

class AddressCheck extends ChangeNotifier{
  bool doc = false;

  changeToTrue() {
    doc = true;
    notifyListeners();
  }

  changeToFalse() {
    doc = false;
    notifyListeners();
  }
}
