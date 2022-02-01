import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier{
  
  int _counter = 0;
  int get counter => _counter;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  void _setPreferencesItem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt('cart_item', _counter);
    preferences.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPreferencesItem() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _counter = preferences.getInt('cart_item') ?? 0;
    _totalPrice = preferences.getDouble('total_price') ?? 0.0;
    notifyListeners();
  }

  void addCounter (){
  _counter++;
  _setPreferencesItem();
  notifyListeners();
  }

  void removeCounter (){
  _counter--;
  _setPreferencesItem();
  notifyListeners();
  }

  int getCounter (){
  _getPreferencesItem();
  return _counter;
  }


  void addTotalPrice (double productPrice){
  _totalPrice = _totalPrice + productPrice;
  _setPreferencesItem();
  notifyListeners();
  }

  void removeTotalPrice (double productPrice){
  _totalPrice = _totalPrice - productPrice;
  _setPreferencesItem();
  notifyListeners();
  }

  double getTotalPrice (){
  _getPreferencesItem();
  return _totalPrice;
  }




}