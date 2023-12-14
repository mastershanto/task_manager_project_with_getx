import 'package:flutter/material.dart';

class TextFormat {
  dynamic textFormatOne() {
    return Text(
      "\n\nTextStyle({Color? color,TextDecoration? decoration,"
      "\n\nColor? decorationColor,TextDecorationStyle? decorationStyle,"
      "\n\ndouble? decorationThickness,FontWeight? fontWeight,FontStyle? fontStyle,"
      "\n\nTextBaseline? textBaseline,String? fontFamily,List<String>? fontFamilyFallback,"
      "\n\ndouble? fontSize,double? letterSpacing,double? wordSpacing,"
      "\n\ndouble? height,TextLeadingDistribution? leadingDistribution,"
      "\n\nLocale? locale,Paint? background,Paint? foreground,List<Shadow>? shadows,"
      "\n\nList<FontFeature>? fontFeatures,List<FontVariation>? fontVariations})",
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 0,
          wordSpacing: 20,
          //textBaseline: TextBaseline.alphabetic,
          //color: Colors.blue,
          foreground: Paint()
            ..color = Colors.grey
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          /*background: Paint()
                ..color=Colors.grey
                ..strokeWidth=3.0
                ..style=PaintingStyle.stroke,*/
          backgroundColor: Colors.black,
          //fontStyle: FontStyle.italic,
          //decoration: TextDecoration.underline,
          decoration: TextDecoration.combine([
            TextDecoration.overline,
            //TextDecoration.lineThrough,
            TextDecoration.underline
          ]),
          decorationColor: Colors.yellow,
          decorationStyle: TextDecorationStyle.solid,
          shadows: [
            Shadow(color: Colors.grey, blurRadius: 5.0, offset: Offset(4, 1)),
          ]),
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      textScaleFactor: 1,
      softWrap: false,
      maxLines: 10,
      semanticsLabel: "Text_Widget",
    );
  }
}
