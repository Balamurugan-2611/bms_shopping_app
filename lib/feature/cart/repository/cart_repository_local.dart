import 'package:bms_shopping_app/db/db_provider.dart';
import 'package:bms_shopping_app/feature/cart/models/cart.dart';
import 'package:bms_shopping_app/feature/cart/models/cart_item.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:sqflite/sqflite.dart'; // Updated import

import 'cart_repository.dart';

class CartRepositoryLocal extends CartRepository {
  Database? _db;

  CartRepositoryLocal() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    _db = await DBProvider.instance.database;
  }

  @override
  Future<Cart> getCartItems() async {
    if (_db == null) {
      await _initializeDatabase();
    }

    final res = await _db!.rawQuery("""
      SELECT * FROM ${DBProvider.TABLE_CART_ITEMS}
      JOIN ${DBProvider.TABLE_PRODUCT}
      ON ${DBProvider.TABLE_PRODUCT}.product_id
      = ${DBProvider.TABLE_CART_ITEMS}.product_id
    """);

    final cartItems = res.map((data) {
      return CartItem(
        id: data['cart_items_id'] as int,
        quantity: data['quantity'] as int,
        product: Product.fromMap(data),
      );
    }).toList();

    return Cart(cartItems);
  }

  Future<void> updateQuantity(Product product, int value) async {
    if (_db == null) {
      await _initializeDatabase();
    }

    await _db!.update(
      DBProvider.TABLE_CART_ITEMS,
      {'quantity': value},
      where: 'product_id = ?',
      whereArgs: [product.id],
    );
  }

  Future<void> removeCartItem(CartItem cartItem) async {
    if (_db == null) {
      await _initializeDatabase();
    }

    await _db!.delete(
      DBProvider.TABLE_CART_ITEMS,
      where: 'cart_items_id = ?',
      whereArgs: [cartItem.id],
    );
  }
}
