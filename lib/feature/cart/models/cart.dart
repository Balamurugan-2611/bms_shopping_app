// ignore_for_file: depend_on_referenced_packages

import 'package:bms_shopping_app/feature/cart/models/cart_item.dart';

class Cart {
  List<CartItem> listCartItem = List<CartItem>();

  Cart(this.listCartItem);

  double getTotalPrice() {
    double sum = 0;
    listCartItem.forEach((element) {
      sum += (element.quantity * element.product.price);
    });

    return sum;
  }
}
