import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms_shopping_app/db/db_provider.dart';
import 'package:bms_shopping_app/feature/cart/models/cart_item.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ProductDetailsRepository {
  late Database db;
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  ProductDetailsRepository() {
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    db = await DBProvider.instance.database;
  }

  Future<int> insertProductToCart(Product product) async {
    await db.insert(
      DBProvider.TABLE_PRODUCT,
      product.toMapSql(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final List<Map<String, dynamic>> findCartItem = await db.query(
      DBProvider.TABLE_CART_ITEMS,
      where: 'product_id = ?',
      whereArgs: [product.id],
    );

    if (findCartItem.isEmpty) {
      final cartItem = CartItem(product: product, quantity: 1).toMap();
      return await db.insert(
        DBProvider.TABLE_CART_ITEMS,
        cartItem,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } else {
      final currentQuantity = findCartItem.first['quantity'] ?? 0;
      return await db.update(
        DBProvider.TABLE_CART_ITEMS,
        {'quantity': currentQuantity + 1},
        where: 'product_id = ?',
        whereArgs: [product.id],
      );
    }
  }

  Future<void> addToWishlist(Product product) async {
    await productCollection.doc(product.id).update({'isFavourite': true});
  }

  Future<Product> getProductDetails(String id) async {
    final DocumentSnapshot result = await productCollection.doc(id).get();
    return _productListFromSnapshot(result);
  }

  Product _productListFromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      images: List<String>.from(data['images']),
      colors: data['colors'],
      title: data['title'],
      price: data['price'].toDouble(),
      isFavourite: data['isFavourite'],
      category: data['category'],
      description: data['description'],
      briefDescription: data['briefDescription'],
      remainingSizeUK: List<double>.from(data['remainingSizeUK']),
      remainingSizeUS: List<double>.from(data['remainingSizeUS']),
      productType: data['productType'],
    );
  }
}
