part of 'discover_bloc.dart';

abstract class DiscoverEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class DiscoverUpdatedEvent extends DiscoverEvent {
  final List<Product> products;
  final String category;
  final String productType;

  DiscoverUpdatedEvent({
    required this.products,
    required this.category,
    required this.productType,
  });

  @override
  List<Object?> get props => [products, category, productType];
}

class LoadingDiscoverEvent extends DiscoverEvent {
  final String category;
  final String productType;

  LoadingDiscoverEvent({
    required this.category,
    required this.productType,
  });

  @override
  List<Object?> get props => [category, productType];
}

class LoadingWishlistEvent extends DiscoverEvent {}

class WishlistUpdatedEvent extends DiscoverEvent {
  final List<Product> products;

  WishlistUpdatedEvent({required this.products});

  @override
  List<Object?> get props => [products];
}
