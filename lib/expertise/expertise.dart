import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../theme/theme.dart';
import 'skillcard.dart';
import 'skilsdata.dart'; // Import SkillCard

class SkillsPage extends StatelessWidget {
  final double appBarHeight;

  SkillsPage({required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    // Get screen size
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Define font sizes dynamically based on screen width
    double baseFontSize = (screenWidth * 0.015).clamp(14.0, 26.0);
    double headingFontSize = (baseFontSize * 1.5).clamp(18.0, 36.0);

    // Dynamically determine the number of cards per row
    int cardsPerRow = screenWidth > 1100
        ? 5
        : screenWidth > 900
            ? 4
            : screenWidth > 700
                ? 3
                : 2;

    // Calculate card size based on screen width
    double cardWidth = (screenWidth / (cardsPerRow + 0.3)) * 0.90;
    double cardHeight = cardWidth * 0.78;

    // Clamp card sizes for better responsiveness
    cardWidth = cardWidth.clamp(90, 150);
    cardHeight = cardHeight.clamp(80, 120);

    // Define spacing between elements
    double headingBottomSpacing = (screenHeight * 0.07).clamp(40, 100);
    double dynamicSpacing = (screenWidth * 0.02).clamp(10, 30);
    double dynamicRunSpacing = (screenWidth * 0.025).clamp(12, 35);

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Heading
              // AnimatedTextKit(
              //   animatedTexts: [
              //     TypewriterAnimatedText(
              //       'My Expertise',
              //       speed: const Duration(milliseconds: 100),
              //       textStyle: TextStyle(
              //         fontFamily: 'Space',
              //         color: isDarkMode ? primaryColor : primaryColorLight,
              //         letterSpacing: 1,
              //         fontSize: headingFontSize,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ],
              //   isRepeatingAnimation: false,
              // ),
              Text(
                "My Expertise",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: headingFontSize,
                  letterSpacing: 1,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: headingBottomSpacing),

              // Skills Grid using Wrap
              Wrap(
                alignment: WrapAlignment.center,
                spacing: dynamicSpacing, // Horizontal spacing
                runSpacing: dynamicRunSpacing, // Vertical spacing
                children: skills.map((skill) {
                  return SkillCard(
                    icon: skill["icon"]!,
                    name: skill["name"]!,
                    description: skill["description"]!,
                    height: cardHeight,
                    width: cardWidth,
                    isDarkMode: isDarkMode,
                  );
                }).toList(),
              ),
              SizedBox(height: headingBottomSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
