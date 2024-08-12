import 'dart:math';

import 'package:flutter/material.dart';
import 'package:bms_shopping_app/feature/credit_card_details/models/credit_card_model.dart';
import 'package:bms_shopping_app/resources/R.dart';

class CreditCardWidget extends StatelessWidget {
  final CreditCard creditCard;
  final TextStyle? textStyle;
  final Color cardBgColor;
  final double? height;
  final double? width;

  const CreditCardWidget({
    Key? key,
    required this.creditCard,
    this.height,
    this.width,
    this.textStyle,
    this.cardBgColor = const Color(0xff1b447b),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Orientation orientation = MediaQuery.of(context).orientation;

    return buildFrontContainer(width, height, context, orientation);
  }

  /// Builds a front container containing
  /// Card number, Exp. year and Card holder name
  Container buildFrontContainer(
    double width,
    double height,
    BuildContext context,
    Orientation orientation,
  ) {
    final TextStyle defaultTextStyle = Theme.of(context).textTheme.titleMedium!.copyWith(
          color: Colors.white,
          fontFamily: 'halter',
          fontSize: 16,
        );

    return Container(
      margin: const EdgeInsets.all(16),
      width: width,
      height: height ?? (orientation == Orientation.portrait ? height / 4 : height / 2),
      child: Stack(
        children: <Widget>[
          getRandomBackground(height, width, creditCard.color),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 0),
                  blurRadius: 12,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getChipImage(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: getCardTypeIcon(creditCard.cardNumber),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    creditCard.cardNumber.isEmpty
                        ? 'XXXX XXXX XXXX XXXX'
                        : creditCard.cardNumber,
                    style: textStyle ?? defaultTextStyle,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 6),
                            child: Text(
                              'Card holder',
                              style: TextStyle(
                                color: Colors.white38,
                                fontFamily: 'halter',
                                fontSize: 9,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              child: Text(
                                creditCard.cardHolderName.isEmpty
                                    ? 'CARD HOLDER'
                                    : creditCard.cardHolderName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'halter',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 6, right: 32),
                            child: Text(
                              'Expiry',
                              style: TextStyle(
                                color: Colors.white38,
                                fontFamily: 'halter',
                                fontSize: 9,
                              ),
                            ),
                          ),
                          Text(
                            creditCard.expiryDate.isEmpty
                                ? 'MM/YY'
                                : creditCard.expiryDate,
                            style: textStyle ?? defaultTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Determines the Credit Card type based on cardPatterns and returns it.
  CardType detectCCType(String cardNumber) {
    // Default card type is other
    CardType cardType = CardType.otherBrand;

    if (cardNumber.isEmpty) {
      return cardType;
    }

    for (var entry in cardNumPatterns.entries) {
      final CardType type = entry.key;
      final Set<List<String>> patterns = entry.value;

      for (var patternRange in patterns) {
        // Remove any spaces
        String ccPatternStr = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
        final int rangeLen = patternRange[0].length;
        // Trim the Credit Card number string to match the pattern prefix length
        if (rangeLen < cardNumber.length) {
          ccPatternStr = ccPatternStr.substring(0, rangeLen);
        }

        if (patternRange.length > 1) {
          // Convert the prefix range into numbers and check if the Credit Card number is in the range
          final int ccPrefixAsInt = int.parse(ccPatternStr);
          final int startPatternPrefixAsInt = int.parse(patternRange[0]);
          final int endPatternPrefixAsInt = int.parse(patternRange[1]);
          if (ccPrefixAsInt >= startPatternPrefixAsInt && ccPrefixAsInt <= endPatternPrefixAsInt) {
            // Found a match
            cardType = type;
            break;
          }
        } else {
          // Compare the single pattern prefix with the Credit Card prefix
          if (ccPatternStr == patternRange[0]) {
            // Found a match
            cardType = type;
            break;
          }
        }
      }
    }

    return cardType;
  }

  /// Returns the icon for the card type, or an empty container if not found.
  Widget getCardTypeIcon(String cardNumber) {
    final CardType type = detectCCType(cardNumber);

    switch (type) {
      case CardType.visa:
        return Image.asset(
          R.icon.visaCard,
          height: 64,
          width: 64,
        );
      case CardType.americanExpress:
        return Image.asset(
          R.icon.amexCard,
          height: 64,
          width: 64,
        );
      case CardType.mastercard:
        return Image.asset(
          R.icon.masterCard,
          height: 64,
          width: 64,
        );
      case CardType.discover:
        return Image.asset(
          R.icon.discoverCard,
          height: 64,
          width: 64,
        );
      default:
        return Container(
          height: 64,
          width: 64,
        );
    }
  }
}

enum CardType {
  otherBrand,
  mastercard,
  visa,
  americanExpress,
  discover,
}

Container getRandomBackground(
    double height, double width, Color color) {
  return Container(
    child: Flex(
      direction: Axis.horizontal,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Container getChipImage() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 16),
    child: Image.asset(
      R.icon.chip,
      height: 52,
      width: 52,
    ),
  );
}

/// Credit Card prefix patterns
Map<CardType, Set<List<String>>> cardNumPatterns = {
  CardType.visa: {
    ['4'],
  },
  CardType.americanExpress: {
    ['34'],
    ['37'],
  },
  CardType.discover: {
    ['6011'],
    ['622126', '622925'],
    ['644', '649'],
    ['65'],
  },
  CardType.mastercard: {
    ['51', '55'],
    ['2221', '2229'],
    ['223', '229'],
    ['23', '26'],
    ['270', '271'],
    ['2720'],
  },
};
