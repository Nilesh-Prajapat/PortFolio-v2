import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillDetailedPage extends StatelessWidget {
  final String skillName;
  final String skillIcon;
  final String skillDescription;

  const SkillDetailedPage({
    super.key,
    required this.skillName,
    required this.skillIcon,
    required this.skillDescription,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    final double containerWidth = screenWidth > 850
        ? (screenWidth * 0.85).clamp(600, 850)
        : (screenWidth * 0.85).clamp(300, 550);

    final double baseFontSize = screenWidth > 850 ? 15 : 13;
    final double iconSize = screenWidth > 850 ? 22 : 16;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDarkMode ? const Color(0xFF252526) : const Color(0xFFE0E0E0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(skillIcon, height: iconSize + 4, width: iconSize + 4),
                          const SizedBox(width: 5),
                          Text(
                            "$skillName.dart",
                            style: GoogleFonts.spaceMono(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: baseFontSize,
                            ),
                          ),
                          const Spacer(),

                          IconButton(
                            icon: Icon(Icons.close, color: isDarkMode ? Colors.white : Colors.black, size: iconSize),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          children: _getFormattedText(skillDescription, isDarkMode, baseFontSize),
                          style: GoogleFonts.spaceMono(

                            color: isDarkMode ? Colors.white : Colors.black,
                            fontSize: baseFontSize,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<TextSpan> _getFormattedText(String text, bool isDarkMode, double fontSize) {
    final RegExp exp = RegExp(r'\*\*(.*?)\*\*');
    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final Match match in exp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }

      spans.add(
        TextSpan(
          text: match.group(1),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: fontSize),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex)));
    }

    return spans;
  }
}