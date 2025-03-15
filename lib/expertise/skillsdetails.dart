import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillDetailedPage extends StatefulWidget {
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
  _SkillDetailedPageState createState() => _SkillDetailedPageState();
}

class _SkillDetailedPageState extends State<SkillDetailedPage> {
  late double xPos;
  late double yPos;
  late double containerWidth;
  late double containerHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // ✅ Define containerWidth & containerHeight to avoid "Undefined name" error
    containerWidth = (screenWidth * 0.85).clamp(300, 850);
    containerHeight = screenHeight * 0.5;

    // ✅ Centering the container
    xPos = (screenWidth - containerWidth) / 2;
    yPos = (screenHeight ) / 3;

    setState(() {}); // Ensure UI updates with calculated values
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double baseFontSize = MediaQuery.of(context).size.width > 850 ? 15 : 13;
    final double iconSize = MediaQuery.of(context).size.width > 850 ? 22 : 16;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: Stack(
          children: [
            Positioned(
              left: xPos,
              top: yPos,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    xPos += details.delta.dx;
                    yPos += details.delta.dy;
                  });
                },
                child: GestureDetector(
                  onTap: () {

                  },
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
                              Image.asset(widget.skillIcon, height: iconSize + 4, width: iconSize + 4),
                              const SizedBox(width: 5),
                              Text(
                                "${widget.skillName}.dart",
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
                              children: _getFormattedText(widget.skillDescription, isDarkMode, baseFontSize),
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
          ],
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
            fontSize: fontSize,
          ),
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
