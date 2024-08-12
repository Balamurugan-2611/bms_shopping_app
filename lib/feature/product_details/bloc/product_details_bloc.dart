import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:bms_shopping_app/feature/product_details/repository/product_details_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsRepository _productDetailsRepository;

  ProductDetailsBloc()
      : _productDetailsRepository = ProductDetailsRepository(),
        super(ProductDetailsInitial());

  @override
  Stream<ProductDetailsState> mapEventToState(ProductDetailsEvent event) async* {
    if (event is AddProductToCart) {
      yield* _mapAddProductToCartToState(event);
    } else if (event is AddToWishlistEvent) {
      yield* _mapAddToWishlistEventToState(event);
    } else if (event is LoadProductDetails) {
      yield* _mapLoadProductDetailsEventToState(event);
    }
  }

  Stream<ProductDetailsState> _mapAddProductToCartToState(
      AddProductToCart event) async* {
    await _productDetailsRepository.insertProductToCart(event.product);
    yield AddProductToBagFinished(true);
  }

  Stream<ProductDetailsState> _mapAddToWishlistEventToState(
      AddToWishlistEvent event) async* {
    await _productDetailsRepository.addToWishlist(event.product);
    // Re-fetch product details to update the state
    add(LoadProductDetails(event.product.id));
  }

  Stream<ProductDetailsState> _mapLoadProductDetailsEventToState(
      LoadProductDetails event) async* {
    try {
      final product = await _productDetailsRepository.getProductDetails(event.productId);
      yield LoadProductDetailsFinished(product);
    } catch (e) {
      // Handle error (could be a separate state for error handling)
      yield ProductDetailsError('Failed to load product details');
    }
  }
}
