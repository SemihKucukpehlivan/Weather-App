import 'package:flutter/material.dart';

class TextStyleConst {
  // Weather main screen temperature
  static const TextStyle temperatureLabelTextStyle =
      TextStyle(fontSize: 70, color: Colors.white, fontFamily: 'Freeman');

  // Weather main screen description
  static const TextStyle descriptionLabelTextStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
  );

  // Weather main screen city
  static const TextStyle cityLabelTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.white,
    fontFamily: 'PoetsenOne',
  );

  // Blur card widget text style
  static const TextStyle blurCardTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  // See more button text style
  static const TextStyle seeMoreButtonTextStyle = TextStyle(
    fontSize: 18,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle descriptionLabelTextStyle2 = TextStyle(
    fontSize: 20,
    color: Colors.black54,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle informationLabelTextStyle = TextStyle(
    fontSize: 15,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle informationValueLabelTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle informationValueLabelTextStyle2 = TextStyle(
    fontSize: 17,
    color: Colors.black87,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle formattedDate = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: 'PlayFair',
  );
}
