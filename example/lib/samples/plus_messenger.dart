import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:examples/data.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PlusSample extends StatefulWidget {
  @override
  State<PlusSample> createState() => PlusSampleState();
}

class PlusSampleState extends State<PlusSample> {
  List<ChatMessage> messages = basicSample;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Color(0xff00ff9f),
          titleTextStyle: TextStyle(
            color: Color(0xff001eff),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Color(0xff001eff),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('PLUS Example'),
        ),
        body: Container(
          color: Color(0xffC988E7),
          child: DashChat(
            currentUser: user,
            onSend: (ChatMessage m) {
              m.status = MessageStatus.received;
              setState(() {
                messages.insert(0, m);
              });
            },
            inputOptions: InputOptions(
              inputTextStyle: const TextStyle(
                color: Color(0xff001eff),
              ),
              inputDecoration: InputDecoration(
                isDense: true,
                filled: true,
                fillColor: const Color(0xff00b8ff),
                contentPadding: const EdgeInsets.only(
                  left: 18,
                  top: 10,
                  bottom: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            messages: messages,
            messageOptions: MessageOptions(
                containerColor: Colors.white,
                currentUserContainerColor: Color(0xff9932CB),
                textColor: Colors.black,
                currentUserTextColor: Colors.white,
                currentUserTimeTextColor: Colors.white,
                messagePadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                showTime: true,
                spaceWhenAvatarIsHidden: 8,
                borderRadiusSmall: 4,
                borderRadius: 16,
                timeFontSize: 10,
                timePadding: EdgeInsets.only(top: 2),
                timeTextColor: Color(0xff8E8E93),
                markdownStyleSheet:
                    MarkdownStyleSheet(p: TextStyle(fontSize: 16))),
            messageListOptions: MessageListOptions(
              padding: EdgeInsets.fromLTRB(0, 34, 0, 34),
              dateSeparatorBuilder: (date) => DefaultDateSeparator(
                date: date,
                height: 26,
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(vertical: 12),
                decorationShape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                        cornerRadius: 12, cornerSmoothing: 0.6)),
                textStyle: const TextStyle(color: Colors.black, fontSize: 12),
              ),
              onLoadEarlier: () async {
                await Future.delayed(const Duration(seconds: 3));
              },
            ),
          ),
        ),
      ),
    );
  }
}
