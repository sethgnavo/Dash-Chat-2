part of '../../../dash_chat_2.dart';

/// {@category Default widgets}
ShapeDecoration defaultMessageDecoration({
  required Color color,
  required double borderTopLeft,
  required double borderTopRight,
  required double borderBottomLeft,
  required double borderBottomRight,
  required double cornerSmoothing,
}) =>
    ShapeDecoration(
      color: color,
      shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius.only(
        topLeft: SmoothRadius(
            cornerRadius: borderTopLeft, cornerSmoothing: cornerSmoothing),
        topRight: SmoothRadius(
            cornerRadius: borderTopRight, cornerSmoothing: cornerSmoothing),
        bottomLeft: SmoothRadius(
            cornerRadius: borderBottomLeft, cornerSmoothing: cornerSmoothing),
        bottomRight: SmoothRadius(
            cornerRadius: borderBottomRight, cornerSmoothing: cornerSmoothing),
      )),
    );
