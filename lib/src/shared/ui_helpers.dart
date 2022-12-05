// Horizontal Spacing
import 'package:flutter/material.dart';

const double sizeTiny = 5.0;
const double sizeSmall = 10.0;
const double sizeMedium = 25.0;
const double sizeLarge = 50.0;
const double sizeMassive = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: sizeTiny);
const Widget horizontalSpaceSmall = SizedBox(width: sizeSmall);
const Widget horizontalSpaceMedium = SizedBox(width: sizeMedium);
const Widget horizontalSpaceLarge = SizedBox(width: sizeLarge);
const Widget horizontalSpaceMassive = SizedBox(width: sizeMassive);

const Widget verticalSpaceTiny = SizedBox(height: sizeTiny);
const Widget verticalSpaceSmall = SizedBox(height: sizeSmall);
const Widget verticalSpaceMedium = SizedBox(height: sizeMedium);
const Widget verticalSpaceLarge = SizedBox(height: sizeLarge);
const Widget verticalSpaceMassive = SizedBox(height: sizeMassive);

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;
