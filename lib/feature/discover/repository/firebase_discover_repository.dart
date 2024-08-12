import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:bms_shopping_app/feature/discover/repository/discover_repository.dart';

class FirebaseDiscoverRepository extends DiscoverRepository {
  final CollectionReference discoverCollection = FirebaseFirestore.instance.collection('products');

  @override
  Stream<List<Product>> getListProduct() {
    return discoverCollection.snapshots().map(_productListFromSnapshot);
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;  // Updated to ensure proper type safety
      return Product(
        id: doc.id,
        images: List<String>.from(data['images'] ?? []),
        colors: List<String>.from(data['colors'] ?? []),
        title: data['title'] ?? '',
        price: data['price']?.toDouble() ?? 0.0,  // Ensure price is a double
        isFavourite: data['isFavourite'] ?? false,
        category: data['category'] ?? '',
        description: data['description'] ?? '',
        briefDescription: data['briefDescription'] ?? '',
        remainingSizeUK: List<double>.from(data['remainingSizeUK'] ?? []),
        remainingSizeUS: List<double>.from(data['remainingSizeUS'] ?? []),
        productType: data['productType'] ?? '',
      );
    }).toList();
  }

  @override
  Future<void> addListProduct(List<Product> products) async {
    final batch = FirebaseFirestore.instance.batch();
    for (var product in products) {
      final docRef = discoverCollection.doc(product.id);
      batch.set(docRef, product.toMap());
    }
    await batch.commit();
  }
}
