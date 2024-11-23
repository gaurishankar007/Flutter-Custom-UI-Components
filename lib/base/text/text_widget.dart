import 'package:flutter/material.dart';

part 'text_type_model.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;
  final TextType textType;
  final FontWeight fontWeight;
  final TextDecoration? decoration;
  final Color? decorationColor;

  const TextWidget(
    this.text, {
    super.key,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.color,
    this.textType = TextType.bodyMedium,
    this.fontWeight = FontWeight.normal,
    this.decoration,
    this.decorationColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        color: color,
        fontSize: textType.size,
        fontWeight: fontWeight,
        decoration: decoration,
        decorationColor: decorationColor,
      ),
    );
  }

  factory TextWidget.caption(
    String text, {
    TextAlign? textAlign,
    TextOverflow? overflow,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      TextWidget(
        text,
        textAlign: textAlign,
        overflow: overflow,
        color: color,
        textType: TextType.caption,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  factory TextWidget.bodySmall(
    String text, {
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
  }) =>
      TextWidget(
        text,
        textAlign: textAlign,
        overflow: overflow,
        maxLines: maxLines,
        color: color,
        textType: TextType.bodySmall,
        fontWeight: FontWeight.w400,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  factory TextWidget.bodyLarge(String text, {Color? color}) => TextWidget(
        text,
        color: color,
        textType: TextType.bodyLarge,
        fontWeight: FontWeight.w400,
      );

  factory TextWidget.title(String text, {Color? color}) => TextWidget(
        text,
        color: color,
        textType: TextType.titleSmall,
        fontWeight: FontWeight.w600,
      );

  factory TextWidget.titleMedium(String text, {Color? color}) => TextWidget(
        text,
        color: color,
        textType: TextType.titleMedium,
        fontWeight: FontWeight.w500,
      );

  factory TextWidget.headline(String text, {Color? color}) => TextWidget(
        text,
        color: color,
        textType: TextType.headline,
        fontWeight: FontWeight.w600,
      );

  factory TextWidget.headlineLarge(String text, {Color? color}) => TextWidget(
        text,
        color: color,
        textType: TextType.headlineLarge,
        fontWeight: FontWeight.w600,
      );
}
