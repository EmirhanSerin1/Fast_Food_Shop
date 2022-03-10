class Cart {
  String? idOfPerson; //For the make easier analyist
  String? productName;
  String? productPrice;
  String? imagePath;
  String? numberOfProduct;
  String? totalProductPrice;
  Map? extras;

  Cart(
      {this.idOfPerson,
      this.productName,
      this.productPrice,
      this.imagePath,
      this.numberOfProduct,
      this.totalProductPrice,
      this.extras});

  //For receive data
  factory Cart.fromMap(map) {
    return Cart(
      productName: map['productName'],
      productPrice: map['productPrice'],
      imagePath: map['imagePath'],
      numberOfProduct: map['numberOfProduct'],
      totalProductPrice: map['totalProductPrice'],
    );
  }

  //For send data
  Map<String, dynamic> toMap() {
    return {
      'idOfPerson': idOfPerson,
      'productName': productName,
      'productPrice': productPrice,
      'imagePath': imagePath,
      'numberOfProduct': numberOfProduct,
      'totalProductPrice': totalProductPrice,
      'extras' : {}
    };
  }
}
