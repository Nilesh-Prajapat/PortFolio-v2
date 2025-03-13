import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'github.dart';
import 'skillcard.dart';
import 'skilsdata.dart';

class SkillsPage extends StatelessWidget {
  final double appBarHeight;

  SkillsPage({required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Dynamic font sizes
    double baseFontSize = (screenWidth * 0.013).clamp(12.0, 24.0);
    double headingFontSize = (baseFontSize * 1.3).clamp(18.0, 32.0);

    // Cards per row based on screen width
    int cardsPerRow = screenWidth > 1100
        ? 6
        : screenWidth > 900
        ? 5
        : screenWidth > 700
        ? 4
        : 3;

    // Card size
    double cardWidth = (screenWidth / (cardsPerRow + 0.5)) * 0.85;
    double cardHeight = cardWidth * 0.75;
    cardWidth = cardWidth.clamp(90, 150);
    cardHeight = cardHeight.clamp(80, 120);

    // Dynamic spacing
    double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);
    double skillGitHubSpacing = (screenHeight * 0.03).clamp(14, 35);
    double dynamicSpacing = (screenWidth * 0.02).clamp(10, 30);
    double dynamicRunSpacing = (screenWidth * 0.025).clamp(12, 32);

    return Center(
      child: SizedBox(
        width: screenWidth * 0.95, // Slightly increase width to reduce empty space
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03), // Reduced padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Expertise",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: headingFontSize,
                  letterSpacing: 1,
                  color: isDarkMode ? primaryColor : primaryColorLight,
                ),
              ),
              SizedBox(height: sectionSpacing),

              screenWidth >= 850
                  ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: _buildExpertiseSection(
                        screenWidth,
                        screenHeight,
                        dynamicSpacing,
                        dynamicRunSpacing,
                        isDarkMode,
                        cardWidth,
                        cardHeight,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.01), // Minimal spacing
                    SizedBox( // GitHub stats only take required space
                      width: null, // No forced width, it takes children's size
                      child: GitHubStats(),
                    ),
                  ],
                ),
              )
                  : Column(
                children: [
                  _buildExpertiseSection(
                    screenWidth,
                    screenHeight,
                    dynamicSpacing,
                    dynamicRunSpacing,
                    isDarkMode,
                    cardWidth,
                    cardHeight,
                  ),
                  SizedBox(height: skillGitHubSpacing),
                  GitHubStats(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpertiseSection(
      double screenWidth,
      double screenHeight,
      double dynamicSpacing,
      double dynamicRunSpacing,
      bool isDarkMode,
      double cardWidth,
      double cardHeight,
      ) {
    double baseFontSize = (screenWidth * 0.012).clamp(12, 18);
    double headingFontSize = (baseFontSize * 1.1).clamp(14, 24);
    double headingSpacing = (screenHeight * 0.02).clamp(10, 25);

    bool showQuote = screenWidth > 1020;
    double quoteFontSize = showQuote ? (screenWidth * 0.012).clamp(14, 22) : 0;
    double quoteSpacing = showQuote ? (screenHeight * 0.1).clamp(40, 100) : 0;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: screenHeight * 0.4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Tech Stack",
            style: TextStyle(
              fontSize: headingFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2 * headingSpacing),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: dynamicSpacing,
            runSpacing: dynamicRunSpacing,
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
          SizedBox(height: quoteSpacing),

          if (showQuote)
            Text(
              "“Programming isn't about what you know; it's about what you can figure out.”\n— Chris Pine",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: quoteFontSize,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
        ],
      ),
    );
  }
}
