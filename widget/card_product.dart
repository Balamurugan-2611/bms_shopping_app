import 'package:flutter/material.dart';
import 'package:bms_shopping_app/feature/discover/model/product.dart';
import 'package:bms_shopping_app/resources/R.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  final VoidCallback? onTapCard;

  const CardProduct({
    Key? key,
    required this.product,
    this.onTapCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTapCard,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            width: width * 0.5,
            height: height * 0.4,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nike',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Epic React',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '130',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 12,
            child: Container(
              width: width * 0.5,
              height: height * 0.3,
              child: Image.asset(
                product.images.isNotEmpty ? product.images[0] : '',
                fit: BoxFit.contain,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: IconButton(
              icon: Image.asset(
                R.icon.rightArrow,
                color: Colors.white,
              ),
              onPressed: () {
                // Implement your functionality here
              },
            ),
          ),
        ],
      ),
    );
  }
}
