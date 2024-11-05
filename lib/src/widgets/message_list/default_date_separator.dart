part of '../../../dash_chat_2.dart';

/// {@category Default widgets}
class DefaultDateSeparator extends StatelessWidget {
  const DefaultDateSeparator({
    required this.date,
    this.messageListOptions = const MessageListOptions(),
    this.padding = const EdgeInsets.symmetric(horizontal: 20),
    this.margin = const EdgeInsets.symmetric(vertical: 12),
    this.height = 20,
    this.textStyle = const TextStyle(color: Colors.grey),
    this.decorationShape = const SmoothRectangleBorder(),
    Key? key,
  }) : super(key: key);

  /// Date to show
  final DateTime date;

  /// Options to customize the behaviour and design of the overall list of message
  final MessageListOptions messageListOptions;

  /// Padding of the separator
  final EdgeInsets padding;

  /// Margin of the separator
  final EdgeInsets margin;

  /// Height of the separator
  final double height;

  /// Style of the text
  final TextStyle textStyle;

  /// Shape of the ShapeDecoration, containing all customisations
  final SmoothRectangleBorder decorationShape;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Padding(
        padding: margin,
        child: ClipSmoothRect(
          radius: decorationShape.borderRadius,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              padding: padding,
              //margin: margin,
              height: height,
              decoration: ShapeDecoration(
                  color: Color(0xffF2F2F7).withOpacity(0.8),
                  shape: decorationShape),
              child: Center(
                child: Text(
                  _formatDateSeparator(date),
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDateSeparator(DateTime date) {
    if (messageListOptions.dateSeparatorFormat != null) {
      return messageListOptions.dateSeparatorFormat!.format(date);
    }

    final DateTime today = DateTime.now();

    if (date.year != today.year) {
      return intl.DateFormat('dd MMM yyyy').format(date);
    } else if (date.month != today.month ||
        _getWeekOfYear(date) != _getWeekOfYear(today)) {
      return intl.DateFormat('dd MMM HH:mm').format(date);
    } else if (date.day != today.day) {
      return intl.DateFormat('E HH:mm').format(date);
    }
    return intl.DateFormat('HH:mm').format(date);
  }

  int _getWeekOfYear(DateTime date) {
    final int dayOfYear = int.parse(intl.DateFormat('D').format(date));
    return ((dayOfYear - date.weekday + 10) / 7).floor();
  }
}
