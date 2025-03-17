import 'package:flutter/material.dart';

class SymbolHighlighter extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Color highlightColor;

  const SymbolHighlighter({
    super.key,
    required this.text,
    required this.style,
    required this.highlightColor
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _highlightSymbols(text),
    );
  }

  TextSpan _highlightSymbols(String text) {
    final RegExp symbolRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>/_\-]');
    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (var match in symbolRegex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(
          text: text.substring(lastIndex, match.start),
          style: style,
        ));
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: style.copyWith(
            color: highlightColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(lastIndex),
        style: style,
      ));
    }

    return TextSpan(children: spans);
  }
}
List<TextSpan> getFormattedText(String text, {required bool isDarkMode, required double fontSize}) {
  final RegExp exp = RegExp(r'\*\*(.*?)\*\*');
  List<TextSpan> spans = [];
  int lastIndex = 0;

  for (final Match match in exp.allMatches(text)) {
    // Add normal text before the bold match
    if (match.start > lastIndex) {
      spans.add(TextSpan(
        text: text.substring(lastIndex, match.start),
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontSize: fontSize,
        ),
      ));
    }

    // Add bold text
    String? boldText = match.group(1);
    if (boldText != null && boldText.isNotEmpty) {
      spans.add(
        TextSpan(
          text: boldText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: fontSize,
          ),
        ),
      );
    }

    lastIndex = match.end;
  }

  // Add any remaining text after the last match
  if (lastIndex < text.length) {
    spans.add(TextSpan(
      text: text.substring(lastIndex),
      style: TextStyle(
        color: isDarkMode ? Colors.white : Colors.black,
        fontSize: fontSize,
      ),
    ));
  }

  return spans;
}
