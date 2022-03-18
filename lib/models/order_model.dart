class Order {
  String? orderDate;
  String? totalPrice;
  Map? orders;
 


  Order({
    this.orderDate,
    this.totalPrice,
    this.orders
  });

  //For send data
  Map<String, dynamic> toMap() {
    return {
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'orders' : orders,
    };
  }

}
