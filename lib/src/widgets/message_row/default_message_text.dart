part of '../../../dash_chat_2.dart';

/// {@category Default widgets}
class DefaultMessageText extends StatelessWidget {
  const DefaultMessageText({
    required this.message,
    required this.isOwnMessage,
    this.messageOptions = const MessageOptions(),
    this.isPreviousSameAuthor,
    this.isAfterDateSeparator,
    Key? key,
  }) : super(key: key);

  /// Message tha contains the text to show
  final ChatMessage message;

  /// If the message is from the current user
  final bool isOwnMessage;

  /// Options to customize the behaviour and design of the messages
  final MessageOptions messageOptions;

  final bool? isPreviousSameAuthor;
  final bool? isAfterDateSeparator;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!isOwnMessage &&
            messageOptions.showOtherUsersName &&
            (!isPreviousSameAuthor! || isAfterDateSeparator!))
          Positioned(
              left: 0,
              top: 0,
              child: messageOptions.userNameBuilder != null
                  ? messageOptions.userNameBuilder!(message.user)
                  : DefaultUserName(user: message.user)),
        Padding(
          padding: (!isOwnMessage &&
                  messageOptions.showOtherUsersName &&
                  (!isPreviousSameAuthor! || isAfterDateSeparator!))
              ? const EdgeInsets.only(top: 18)
              : EdgeInsets.zero,
          child: RichText(
              text: TextSpan(
                  style: TextStyle(textBaseline: TextBaseline.alphabetic),
                  children: _buildWidgetSpansFromMessages(context))),
        ),
        Positioned(
            right: 0,
            bottom: 0,
            child: Text(
              (messageOptions.timeFormat ?? intl.DateFormat('HH:mm'))
                  .format(message.createdAt),
              style: TextStyle(
                color: isOwnMessage
                    ? messageOptions.currentUserTimeTextColor(context)
                    : messageOptions.timeTextColor(),
                fontSize: messageOptions.timeFontSize,
              ),
            ))
      ],
    );
  }

  List<WidgetSpan> _buildWidgetSpansFromMessages(BuildContext context) {
    List<WidgetSpan> spanList = [];
    for (var message in getMessage(context)) {
      spanList.add(WidgetSpan(child: message));
    }

    return spanList;
  }

  List<Widget> getMessage(BuildContext context) {
    if (message.mentions != null && message.mentions!.isNotEmpty) {
      String stringRegex = r'([\s\S]*)';
      String stringMentionRegex = '';
      for (final Mention mention in message.mentions!) {
        stringRegex += '(${mention.title})' r'([\s\S]*)';
        stringMentionRegex += stringMentionRegex.isEmpty
            ? '(${mention.title})'
            : '|(${mention.title})';
      }
      final RegExp mentionRegex = RegExp(stringMentionRegex);
      final RegExp regexp = RegExp(stringRegex);

      RegExpMatch? match = regexp.firstMatch(message.text);
      Mention? mention;
      String? partI;
      bool lastIsMention = false;

      if (match != null) {
        List<Widget> res = <Widget>[];
        match
            .groups(List<int>.generate(match.groupCount, (int i) => i + 1))
            .forEach((String? part) {
          partI = part;
          if (mentionRegex.hasMatch(part!)) {
            try {
              mention = message.mentions?.firstWhere(
                (Mention m) => m.title == part,
              );
            } catch (e) {
              // There is no mention
            }
          }
          if (mention != null) {
            res.add(getMention(context, mention!, false));
            lastIsMention = true;
          } else {
            res.add(getParsePattern(context, part, message.isMarkdown, false));
            lastIsMention = false;
          }
          mention =
              null; //avoid printing a mention twice, since it's declared outside the loop
        });

        if (res.isNotEmpty) {
          res[res.length - 1] = lastIsMention
              ? getMention(context, mention!, true)
              : getParsePattern(context, partI!, message.isMarkdown, true);

          return res;
        }
      }
    }
    return <Widget>[
      getParsePattern(context, message.text, message.isMarkdown, true)
    ];
  }

  Widget getParsePattern(
      BuildContext context, String text, bool isMarkdown, bool appendSpace) {
    return isMarkdown
        ? MarkdownBody(
            data: appendSpace
                ? text +
                    " \u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"
                : text,
            selectable: true,
            styleSheet: messageOptions.markdownStyleSheet,
            onTapLink: (String value, String? href, String title) {
              if (href != null) {
                openLink(href);
              } else {
                openLink(value);
              }
            },
          )
        : ParsedText(
            parse: messageOptions.parsePatterns != null
                ? messageOptions.parsePatterns!
                : defaultParsePatterns,
            text: appendSpace
                ? text +
                    " \u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"
                : text,
            style: TextStyle(
                color: isOwnMessage
                    ? messageOptions.currentUserTextColor(context)
                    : messageOptions.textColor,
                fontSize: messageOptions.fontSize),
          );
  }

  Widget getMention(BuildContext context, Mention mention, bool appendSpace) {
    return RichText(
      text: TextSpan(
        text: appendSpace
            ? mention.title +
                " \u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0\u00A0"
            : mention.title,
        recognizer: TapGestureRecognizer()
          ..onTap = () => messageOptions.onPressMention != null
              ? messageOptions.onPressMention!(mention)
              : null,
        style: TextStyle(
          color: isOwnMessage
              ? messageOptions.currentUserTextColor(context)
              : messageOptions.textColor,
          decoration: TextDecoration.none,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
