import 'package:get/get.dart';

class AddToCartController extends GetxController{

  var quantity = 1.obs;
  var netPrice = 1.obs;

addQuantity(pressed){
    switch (pressed) {
      case "ADD":
        quantity.value++;
        netPrice.value++;
        return;
      case "REMOVE":
          if (quantity > 0) {
            quantity -= 1;
            netPrice -= 1;
          }
        
        return;
    }
}

}