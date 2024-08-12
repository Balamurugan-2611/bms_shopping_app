import 'dart:convert';
import 'package:bms_shopping_app/resources/R.dart';

class ProductType {
  static const UPCOMING = 'Upcoming';
  static const FEATURED = 'Featured';
  static const NEW = 'New';

  static List<String> values() => [UPCOMING, FEATURED, NEW];
}

class Product {
  final String? id;
  final String title;
  final String briefDescription;
  final String description;
  final List<String> images;
  final int colors;
  final double price;
  final String category;
  final bool isFavourite;
  final List<double> remainingSizeUK;
  final List<double> remainingSizeUS;
  final String productType;

  Product({
    this.id,
    required this.images,
    required this.colors,
    this.isFavourite = false,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.briefDescription,
    required this.remainingSizeUK,
    required this.remainingSizeUS,
    required this.productType,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
      'colors': colors,
      'isFavourite': isFavourite,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'briefDescription': briefDescription,
      'remainingSizeUK': remainingSizeUK,
      'remainingSizeUS': remainingSizeUS,
      'productType': productType,
    };
  }

  static Product fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['product_id'],
      images: List<String>.from(json.decode(map['images'])),
      colors: map['colors'],
      title: map['title'],
      price: map['price'],
      isFavourite: map['isFavourite'] == 1,
      category: map['category'],
      description: map['description'],
      briefDescription: map['briefDescription'],
      remainingSizeUK: List<double>.from(json.decode(map['remainingSizeUK'])),
      remainingSizeUS: List<double>.from(json.decode(map['remainingSizeUS'])),
      productType: map['productType'],
    );
  }

  Map<String, dynamic> toMapSql() {
    return {
      'product_id': id,
      'images': json.encode(images),
      'colors': colors,
      'isFavourite': isFavourite ? 1 : 0,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'briefDescription': briefDescription,
      'remainingSizeUK': json.encode(remainingSizeUK),
      'remainingSizeUS': json.encode(remainingSizeUS),
      'productType': productType,
    };
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, briefDescription: $briefDescription, description: $description, images: $images, colors: $colors, price: $price, isFavourite: $isFavourite, remainingSizeUK: $remainingSizeUK, remainingSizeUS: $remainingSizeUS, productType: $productType}';
  }
}

List<Product> demoProducts = [
  Product(
    images: [R.icon.snkr02],
    colors: 0xFF82B1FF,
    title: 'Air-Max-273-Big-KIDS',
    price: 130.0,
    category: 'Nike',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.UPCOMING,
  ),
  Product(
    images: [R.icon.snkr01],
    colors: 0xFF82B1FF,
    title: 'Air-Max-274-Big-KIDS',
    price: 130.0,
    category: 'Adidas',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.FEATURED,
  ),
  Product(
    images: [R.icon.snkr03],
    colors: 0xFF82B1FF,
    title: 'Air-Max-275-Big-KIDS',
    price: 130.0,
    category: 'Puma',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.NEW,
  ),
  Product(
    images: [R.icon.snkr02],
    colors: 0xFF82B1FF,
    title: 'Air-Max-276-Big-KIDS',
    price: 130.0,
    category: 'Nike',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.UPCOMING,
  ),
  Product(
    images: [R.icon.snkr01],
    colors: 0xFF82B1FF,
    title: 'Air-Max-277-Big-KIDS',
    price: 130.0,
    category: 'Adidas',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.FEATURED,
  ),
  Product(
    images: [R.icon.snkr03],
    colors: 0xFF82B1FF,
    title: 'Air-Max-278-Big-KIDS',
    price: 130.0,
    category: 'Puma',
    description: 'description',
    briefDescription: 'briefDescription',
    remainingSizeUK: [7.5, 8, 9],
    remainingSizeUS: [40, 41, 42],
    productType: ProductType.NEW,
  ),
];

List<String> categories = ['Nike', 'Adidas', 'Puma', 'Converse'];
