import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bms_shopping_app/resources/R.dart';

class CreditCard {
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool isCvvFocused;
  final MaterialColor color;
  final String image;

  CreditCard({
    required this.cardNumber,
    required this.expiryDate,
    required this.cardHolderName,
    required this.cvvCode,
    this.isCvvFocused = false,
    required this.color,
    required this.image,
  });
}

List<CreditCard> creditCards = [
  CreditCard(
    cardNumber: "4348 7374 8374 9873",
    expiryDate: "07/24",
    cvvCode: "333",
    cardHolderName: "AB De Villiers",
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    image: R.icon.visaCard,
  ),
  CreditCard(
    cardNumber: "5500 0000 0000 0004",
    expiryDate: "09/22",
    cvvCode: "34",
    cardHolderName: "Dhoni MS",
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    image: R.icon.masterCard,
  ),
  CreditCard(
    cardNumber: "3400 0000 0000 009",
    expiryDate: "05/15",
    cvvCode: "65",
    cardHolderName: "Bala s",
    color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
    image: R.icon.amexCard,
  ),
];
