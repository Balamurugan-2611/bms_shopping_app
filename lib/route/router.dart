import 'package:flutter/material.dart';
import 'package:bms_shopping_app/feature/auth/login/login_screen.dart';
import 'package:bms_shopping_app/feature/auth/register/register_screen.dart';
import 'package:bms_shopping_app/feature/cart/ui/cart_screen.dart';
import 'package:bms_shopping_app/feature/checkout/checkout_screen.dart';
import 'package:bms_shopping_app/feature/credit_card_details/card_details_screen.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:bms_shopping_app/feature/home/home.dart';
import 'package:bms_shopping_app/feature/product_category/product_categorys_screen.dart';
import 'package:bms_shopping_app/feature/product_details/ui/product_details_screen.dart';
import 'package:bms_shopping_app/feature/shipping/shipping_method_screen.dart';
import 'package:bms_shopping_app/route/slide_route_builder.dart';
import 'route_constants.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstant.homeRoute:
        return SlideRouteBuilder(page: HomeScreen());

      case RouteConstant.productDetailsRoute:
        final String? productId = settings.arguments as String?;
        if (productId != null) {
          return SlideRouteBuilder(
            page: ProductDetailsScreen(productId: productId),
          );
        }
        return _errorRoute('Product ID is required');

      case RouteConstant.loginRoute:
        return SlideRouteBuilder(page: LoginScreen());

      case RouteConstant.registerRoute:
        return SlideRouteBuilder(page: RegisterScreen());

      case RouteConstant.cart:
        return SlideRouteBuilder(page: CartScreen());

      case RouteConstant.shippingMethod:
        return SlideRouteBuilder(page: ShippingMethodScreen());

      case RouteConstant.creditCard:
        return SlideRouteBuilder(page: CreditCardDetailsScreen());

      case RouteConstant.checkout:
        return SlideRouteBuilder(page: CheckoutScreen());

      case RouteConstant.productCategory:
        final arguments = settings.arguments as Map<String, dynamic>?;
        if (arguments != null) {
          final List<Product> listProduct = arguments['listProduct'] ?? [];
          final String categoryName = arguments['categoryName'] ?? 'Unknown Category';
          return SlideRouteBuilder(
            page: ProductCategoryScreen(
              listProduct: listProduct,
              categoryName: categoryName,
            ),
          );
        }
        return _errorRoute('Invalid arguments for Product Category');

      default:
        return _errorRoute('No route defined for ${settings.name}');
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}
