import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutMeEditor extends StatelessWidget {
  const AboutMeEditor({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Set a fixed width for large screens
    final double containerWidth = screenWidth > 850
        ? (screenWidth * 0.85).clamp(600, 850) // Large screens: Min 600px, Max 850px
        : (screenWidth * 0.85).clamp(300, 550); // Small screens: Min 300px, Max 500px

    // Adjust font sizes
    final double baseFontSize = screenWidth > 850 ? 15 : 13;
    final double iconSize = screenWidth > 850 ? 22 : 16;

    // Select text based on screen size
    final String aboutMeText = screenWidth > 850 ? fullAboutMeText : shortAboutMeText;

    return GestureDetector(
      onTap: () => Navigator.of(context).pop(), // Close when tapping outside
      child: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {}, // Prevents closing when clicking inside
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
                    // Top File Tab Bar
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
                          Icon(Icons.description,
                              color: isDarkMode ? Colors.white : Colors.black, size: iconSize),
                          const SizedBox(width: 5),
                          Text(
                            "about_me.dart",
                            style: TextStyle(
                              fontFamily: 'Space',
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: baseFontSize,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: Icon(Icons.copy,
                                color: isDarkMode ? Colors.white : Colors.black, size: iconSize),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: aboutMeText));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Copied to clipboard!",
                                      style: TextStyle(
                                          color: isDarkMode ? Colors.white : Colors.black)),
                                  backgroundColor: isDarkMode ? Colors.grey[900] : Colors.grey[300],
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close,
                                color: isDarkMode ? Colors.white : Colors.black, size: iconSize),
                            onPressed: () => Navigator.of(context).pop(), // Close on press
                          ),
                        ],
                      ),
                    ),
                    // Code Editor Content with Bold Text Formatting
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          children: _getFormattedText(aboutMeText, isDarkMode, baseFontSize),
                          style: TextStyle(
                            fontFamily: 'Space',
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
    final RegExp exp = RegExp(r'\*\*(.*?)\*\*'); // Matches **text**
    List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final Match match in exp.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
      }

      spans.add(
        TextSpan(
          text: match.group(1), // Extract text inside **
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

// Full About Me for Large Screens
const String fullAboutMeText = """
👋 Hi, I'm Nilesh Prajapat!  

💻 **Flutter Developer** | 🎮 **FPS Gamer** | 🎓 **Computer Science Student** | 🚀 **Aspiring Game Developer**  

📌 **Education:** Diploma in Computer Science & Engineering **(Graduating June 2025)**  

I am a passionate **Flutter developer** with a keen interest in **building high-performance mobile applications** that offer smooth UI/UX and real-time functionality.  

🎮 **Gaming & Competitive Mindset**  
As an avid **Valorant** and **CS2** player, I thrive in high-stakes, strategy-driven environments that demand precision, quick decision-making, and adaptability—skills I bring into my development work.  

🌱 **Continuous Learning & Growth**  
I am constantly exploring **app optimization techniques**, **real-time data handling**, and **scalable architectures** to enhance mobile experiences.  

🎯 **Future Aspirations**  
My goal is to transition into **game development**, focusing on creating **immersive survival games** with realistic mechanics and compelling storytelling.  

🤝 **Let’s Connect & Innovate!**  
I’m always open to new opportunities, collaborations, and discussions around mobile and game development.  
""";

const String shortAboutMeText = """
👋 Hi, I'm Nilesh Prajapat!  

💻 **Flutter Developer** | 🎮 **FPS Gamer** | 🎓 **CSE Student** | 🚀 **Aspiring Game Developer**  

📌 **Education:** Diploma in **CSE** **(Graduating June 2025)** 

Passionate about **Flutter app development**, focusing on **performance, optimization, and real-time functionality**.  

🎮 **Gaming Enthusiast**  
Competitive **Valorant & CS2** player—leveraging strategy, precision, and quick reflexes both in gaming and development.  

🌱 **Always Learning**  
Exploring **real-time data handling** and **scalable mobile solutions**.  

🎯 **Future Goal:** To develop **realistic survival games** with deep mechanics and engaging storytelling.  

🤝 **Open to collaboration & new opportunities!**  
""";
