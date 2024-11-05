import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:examples/data.dart';
import 'package:flutter/material.dart';

class SpanSample extends StatefulWidget {
  @override
  State<SpanSample> createState() => SpanSampleState();
}

class SpanSampleState extends State<SpanSample> {
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
          title: const Text('Theming Example'),
        ),
        body: Container(
          color: Color(0xffC988E7),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                textBaseline:
                    TextBaseline.alphabetic, // Ensure baseline alignment
              ),
              children: [
                WidgetSpan(
                    child: Text(
                        "This is inline text with passer par Alvin pour entrer pourparlers avec Borna par rapport au déploiement")),
                WidgetSpan(
                  alignment: PlaceholderAlignment
                      .baseline, // Aligns with the text baseline
                  baseline:
                      TextBaseline.alphabetic, // Same baseline as the text
                  child: Icon(Icons.star, size: 16), // Example widget (icon)
                ),
                TextSpan(text: " an icon."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
