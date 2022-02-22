class TotalPrice {
  String? idOfPerson; //For the make easier analyist
  String? totalPrice;
  //String? orderDate; // I will add

  TotalPrice({
    this.idOfPerson,
    this.totalPrice,
  });

  //For receive data
  factory TotalPrice.fromMap(map) {
    return TotalPrice(
      idOfPerson: map['idOfPerson'],
      totalPrice: map['totalPrice'],
    );
  }

//For send data
  Map<String, dynamic> toMap() {
    return {
      'idOfPerson': idOfPerson,
      'totalPrice': totalPrice,
    };
  }
}
