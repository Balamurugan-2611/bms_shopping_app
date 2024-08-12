import 'package:bms_shopping_app/feature/discover/model/product.dart';

class CartItem {
  final int id;
  int quantity;
  Product product;

  CartItem({required this.id, required this.quantity, required this.product});

  Map<String, dynamic> toMap() {
    return {'quantity': quantity, 'product_id': product.id};
  }


}
