import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bms_shopping_app/feature/cart/bloc/cart_bloc.dart';
import 'package:bms_shopping_app/feature/cart/models/cart.dart';
import 'package:bms_shopping_app/feature/cart/models/cart_item.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:bms_shopping_app/resources/app_theme.dart';
import 'package:bms_shopping_app/resources/colors.dart';
import 'package:bms_shopping_app/route/route_constants.dart';
import 'package:bms_shopping_app/widget/alert_dialog.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatCurrency = NumberFormat.simpleCurrency();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CartBloc>(context).add(CartLoadingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoadFinished) {
              final cart = state.cart;
              return Stack(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 28, right: 28, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Bag',
                              style: headingText,
                            ),
                            Text('Total ${cart.listCartItem.length} items')
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: cart.listCartItem.length,
                          itemBuilder: (context, index) {
                            final cartItem = cart.listCartItem[index];
                            return Container(child: _cartItem(cartItem));
                          },
                        ),
                      ),
                      SizedBox(height: 120)
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      child: _resultCart(cart.getTotalPrice()),
                    ),
                  ),
                ],
              );
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _resultCart(double totalPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 1,
          color: Colors.grey[300],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "${formatCurrency.format(totalPrice)}",
                style: boldTextMedium,
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        _nextButton(),
      ],
    );
  }

  Widget _nextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          primary: AppColors.indianRed,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.shippingMethod);
        },
        child: Text(
          'Next',
          style: whiteText,
        ),
      ),
    );
  }

  Widget _cartItem(CartItem cartItem) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.all(24),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(26),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 40,
              child: Center(
                child: Image.asset(
                  cartItem.product.images[0],
                  width: 140,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.product.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                formatCurrency.format(cartItem.product.price),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                    height: 30,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () =>
                          decreaseQuantity(cartItem.product, cartItem),
                      child: Icon(Icons.remove),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "${cartItem.quantity}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 32,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                      onPressed: () =>
                          increaseQuantity(cartItem.product, cartItem),
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  void increaseQuantity(Product product, CartItem cartItem) {
    BlocProvider.of<CartBloc>(context).add(
      ChangeQuantityCartItem(
        product,
        cartItem.quantity + 1,
        cartItem,
      ),
    );
  }

  void decreaseQuantity(Product product, CartItem cartItem) {
    if (cartItem.quantity <= 1) {
      showAlertDialog(
        context,
        "Remove cart items?",
        "Are you sure to remove ${product.title} from the shopping cart",
        () => BlocProvider.of<CartBloc>(context)
            .add(RemoveCartItem(cartItem)),
      );
    } else {
      BlocProvider.of<CartBloc>(context).add(
        ChangeQuantityCartItem(
          product,
          cartItem.quantity - 1,
          cartItem,
        ),
      );
    }
  }
}
