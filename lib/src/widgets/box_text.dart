// ignore_for_file: use_key_in_widget_constructors
import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

class BoxText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;

  BoxText.headingOne(this.text,
      {Color color = kcPrimaryColor, TextAlign align = TextAlign.start})
      : style = heading1Style.copyWith(color: color),
        alignment = align;
  BoxText.headingTwo(this.text,
      {Color color = kcPrimaryColor, TextAlign align = TextAlign.start})
      : style = heading2Style.copyWith(color: color),
        alignment = align;
  BoxText.headingThree(this.text,
      {Color color = kcPrimaryColor, TextAlign align = TextAlign.start})
      : style = heading3Style.copyWith(color: color),
        alignment = align;
  BoxText.headline(this.text,
      {Color color = kcPrimaryColor, TextAlign align = TextAlign.start})
      : style = headlineStyle.copyWith(color: color),
        alignment = align;
  BoxText.subheading(this.text,
      {Color color = kcOnSecondaryColor, TextAlign align = TextAlign.start})
      : style = subheadingStyle.copyWith(color: color),
        alignment = align;
  BoxText.caption(this.text,
      {Color color = kcOnSecondaryColor, TextAlign align = TextAlign.start})
      : style = captionStyle.copyWith(color: color),
        alignment = align;

  BoxText.body(this.text,
      {Color color = kcOnSecondaryColor, TextAlign align = TextAlign.start})
      : style = bodyStyle.copyWith(color: color),
        alignment = align;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}
