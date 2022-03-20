class Order {
  String? orderDate;
  String? totalPrice;
  Map? orders;
  String? address;

  Order({
    this.orderDate,
    this.totalPrice,
    this.orders,
    this.address,
  });

  //For send data
  Map<String, dynamic> toMap() {
    return {
      'orderDate': orderDate,
      'totalPrice': totalPrice,
      'orders': orders,
      'address': address,
    };
  }
}
