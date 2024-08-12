import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bms_shopping_app/feature/shipping/model/ship_method.dart';
import 'package:bms_shopping_app/resources/app_data.dart';
import 'package:bms_shopping_app/resources/resources.dart';
import 'package:bms_shopping_app/route/route_constants.dart';

class ShippingMethodScreen extends StatefulWidget {
  @override
  _ShippingMethodScreenState createState() => _ShippingMethodScreenState();
}

class _ShippingMethodScreenState extends State<ShippingMethodScreen> {
  final formatCurrency = NumberFormat.simpleCurrency();
  int _currentIndexShipMethod = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text(
          'Shipping Method',
          style: headingText1.copyWith(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
            child: Text(
              'Choose your shipping method',
              style: textMedium,
            ),
          ),
          Container(
            color: Colors.grey[300],
            height: 1,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: AppData.shipMethods.length,
              itemBuilder: (context, index) {
                var shipMethod = AppData.shipMethods[index];
                return _buildShippingOption(shipMethod, index);
              },
            ),
          ),
          _buildNextButton()
        ],
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 14.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: AppColors.indianRed,
        ),
        onPressed: () {
          Navigator.pushNamed(context, RouteConstant.checkout);
        },
        child: Text(
          'Next',
          style: whiteText,
        ),
      ),
    );
  }

  Widget _buildShippingOption(ShipMethod shipMethod, int index) {
    bool isSelected = _currentIndexShipMethod == index;

    return InkWell(
      onTap: () {
        setState(() {
          _currentIndexShipMethod = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.cyan[50],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 26, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    shipMethod.title,
                    style: isSelected ? textMediumWhite : textMedium,
                  ),
                  Text(
                    formatCurrency.format(shipMethod.price),
                    style: isSelected ? textMediumWhite : textMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Text(
                shipMethod.description,
                style: isSelected ? minorTextWhite : minorText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
