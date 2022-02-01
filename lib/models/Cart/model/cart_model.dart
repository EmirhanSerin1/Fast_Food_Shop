class Cart{

late final int? id;
final String? productId;
final String? productName;
final int? productPrice;
final int? initialPrice;
final int? quantity;
final String? unitTag;
final String? imagePath;

Cart({
required this.id,
required this.productId,
required this.productName,
required this.productPrice,
required this.initialPrice,
required this.quantity,
required this.unitTag,
required this.imagePath
});

Cart.fromMap(Map<dynamic, dynamic> res)
: id = res['id'],
productId = res['productId'],
productName = res['productName'],
productPrice = res['productPrice'],
initialPrice = res['initialPrice'],
quantity = res['quantity'],
unitTag = res['unitTag'],
imagePath = res['imagePath'];

Map<String, Object?> toMap(){
  return {
    'id' : id,
    'productId' : productId,
    'productName' : productName,
    'productPrice' : productPrice,
    'quantity' : quantity,
    'unitTag' : unitTag,
    'imagePath' : imagePath,

  };
}



}