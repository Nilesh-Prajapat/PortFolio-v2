import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/theme/theme.dart';

class AboutMeEditor extends StatefulWidget {
  const AboutMeEditor({super.key});

  @override
  _AboutMeEditorState createState() => _AboutMeEditorState();
}

class _AboutMeEditorState extends State<AboutMeEditor> {
  late double xPos;
  late double yPos;
  late double screenWidth;
  late double screenHeight;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    final double containerWidth = screenWidth > 850
        ? (screenWidth * 0.85).clamp(600, 850)
        : (screenWidth * 0.85).clamp(300, 550);

    final double containerHeight = screenWidth > 850 ? 350 : 300;

    // Centering the window
    xPos = (screenWidth - containerWidth) / 2;
    yPos = (screenHeight) / 10;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final double containerWidth = screenWidth > 850
        ? (screenWidth * 0.85).clamp(600, 850)
        : (screenWidth * 0.85).clamp(300, 550);

    final double baseFontSize = screenWidth > 850 ? 15 : 13;
    final double iconSize = screenWidth > 850 ? 22 : 16;

    final String aboutMeText =
        screenWidth > 850 ? fullAboutMeText : shortAboutMeText;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              color: isDarkMode
                  ? Colors.black
                  : Colors.white, // Updated background color
            ),
          ),
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
                onTap: () {}, // Prevents closing when tapped inside
                child: Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    color: isDarkMode
                        ? const Color(0xFF1E1E1E)
                        : const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color(0xFF252526)
                              : const Color(0xFFE0E0E0),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.description,
                                color:
                                    isDarkMode ? darkTextColor : lightTextColor,
                                size: iconSize),
                            const SizedBox(width: 5),
                            Text(
                              "about_me.dart",
                              style: GoogleFonts.spaceMono(
                                color:
                                    isDarkMode ? darkTextColor : lightTextColor,
                                fontSize: baseFontSize,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.copy,
                                  color: isDarkMode
                                      ? darkTextColor
                                      : lightTextColor,
                                  size: iconSize),
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: aboutMeText));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Copied to clipboard!",
                                        style: TextStyle(
                                            color: isDarkMode
                                                ? Colors.white
                                                : Colors.black)),
                                    backgroundColor: isDarkMode
                                        ? Colors.grey[900]
                                        : Colors.grey[300],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.close,
                                  color: isDarkMode
                                      ? darkTextColor
                                      : lightTextColor,
                                  size: iconSize),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: RichText(
                          text: TextSpan(
                            children: _getFormattedText(
                                aboutMeText, isDarkMode, baseFontSize),
                            style: GoogleFonts.spaceMono(
                              color:
                                  isDarkMode ? darkTextColor : lightTextColor,
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
    );
  }

  List<TextSpan> _getFormattedText(
      String text, bool isDarkMode, double fontSize) {
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
              color: isDarkMode ? darkTextColor : lightTextColor,
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

// Full About Me for Large Screens
const String fullAboutMeText = """
Hi, I'm Nilesh Prajapat!  

**Flutter Developer** | **FPS Gamer** | **Computer Science Student** | **Aspiring Game Developer**  

**Education:** Diploma in Computer Science & Engineering **(Graduating June 2025)**  

I am a passionate **Flutter developer** with a keen interest in **building high-performance mobile applications** that offer smooth UI/UX and real-time functionality.  

**Gaming & Competitive Mindset**  
As an avid **Valorant** and **CS2** player, I thrive in high-stakes, strategy-driven environments that demand precision, quick decision-making, and adaptability—skills I bring into my development work.  

**Continuous Learning & Growth**  
I am constantly exploring **app optimization techniques**, **real-time data handling**, and **scalable architectures** to enhance mobile experiences.  

**Future Aspirations**  
My goal is to transition into **game development**, focusing on creating **immersive survival games** with realistic mechanics and compelling storytelling.  

**Let’s Connect & Innovate!**  
I’m always open to new opportunities, collaborations, and discussions around mobile and game development.  
""";

const String shortAboutMeText = """
Hi, I'm Nilesh Prajapat!  

**Flutter Developer** | **FPS Gamer** | **CSE Student** | **Aspiring Game Developer**  

**Education:** Diploma in **CSE** **(Graduating June 2025)** 

Passionate about **Flutter app development**, focusing on **performance, optimization, and real-time functionality**.  

**Gaming Enthusiast**  
Competitive **Valorant & CS2** player—leveraging strategy, precision, and quick reflexes both in gaming and development.  

**Always Learning**  
Exploring **real-time data handling** and **scalable mobile solutions**.  

**Future Goal:** To develop **realistic survival games** with deep mechanics and engaging storytelling.  

**Open to collaboration & new opportunities!**  
""";
