import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bms_shopping_app/feature/cart/models/cart.dart';
import 'package:bms_shopping_app/feature/cart/models/cart_item.dart';
import 'package:bms_shopping_app/feature/cart/repository/cart_repository.dart';
import 'package:bms_shopping_app/feature/cart/repository/cart_repository_local.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepositoryLocal;

  CartBloc()
      : _cartRepositoryLocal = CartRepositoryLocal(),
        super(CartInit());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is CartLoadingEvent) {
      yield* _mapCartLoadingEventToState();
    } else if (event is ChangeQuantityCartItem) {
      yield* _mapChangeQuantityCartItemEventToState(event);
    } else if (event is RemoveCartItem) {
      yield* _mapRemoveCartItemEventToState(event);
    }
  }

  Stream<CartState> _mapCartLoadingEventToState() async* {
    try {
      final result = await _cartRepositoryLocal.getCartItems();
      yield CartLoadFinished(result);
    } catch (_) {
      yield CartLoadError();
    }
  }

  Stream<CartState> _mapChangeQuantityCartItemEventToState(
      ChangeQuantityCartItem event) async* {
    try {
      await _cartRepositoryLocal.updateQuantity(event.product, event.value);
      final result = await _cartRepositoryLocal.getCartItems();
      yield CartLoadFinished(result);
    } catch (_) {
      yield CartLoadError();
    }
  }

  Stream<CartState> _mapRemoveCartItemEventToState(
      RemoveCartItem event) async* {
    try {
      await _cartRepositoryLocal.removeCartItem(event.cartItem);
      final result = await _cartRepositoryLocal.getCartItems();
      yield CartLoadFinished(result);
    } catch (_) {
      yield CartLoadError();
    }
  }
}
