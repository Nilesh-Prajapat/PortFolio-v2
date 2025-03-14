import 'package:flutter/material.dart';
import '../theme/theme.dart';
import 'github.dart';
import 'skillcard.dart';
import 'skilsdata.dart';

class SkillsPage extends StatefulWidget {
  final double appBarHeight;

  const SkillsPage({Key? key, required this.appBarHeight}) : super(key: key);

  @override
  _SkillsPageState createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // Prevents widget from rebuilding unnecessarily

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Dynamic font sizes
    final double baseFontSize = (screenWidth * 0.013).clamp(12.0, 24.0);
    final double headingFontSize = (baseFontSize * 1.3).clamp(18.0, 32.0);

    // Cards per row based on screen width
    final int cardsPerRow = screenWidth > 1100
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
    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);
    final double skillGitHubSpacing = (screenHeight * 0.03).clamp(14, 35);
    final double dynamicSpacing = (screenWidth * 0.02).clamp(10, 30);
    final double dynamicRunSpacing = (screenWidth * 0.025).clamp(12, 32);

    return Center(
      child: SizedBox(
        width: screenWidth * 0.95,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(), // Smooth scrolling
            children: [
              Text(
                "Expertise",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: headingFontSize,
                  letterSpacing: 1,
                  color: isDarkMode ? primaryColor : primaryColorLight,
                ),
              ),
              SizedBox(height: sectionSpacing),
              if (screenWidth >= 850)
                Row(
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
                    SizedBox(width: screenWidth * 0.01),
                     GitHubStats(),
                  ],
                )
              else
                Column(
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
    final double baseFontSize = (screenWidth * 0.012).clamp(12, 18);
    final double headingFontSize = (baseFontSize * 1.1).clamp(14, 24);
    final double headingSpacing = (screenHeight * 0.02).clamp(10, 25);

    final bool showQuote = screenWidth > 1020;
    final double quoteFontSize = showQuote ? (screenWidth * 0.012).clamp(14, 22) : 0;
    final double quoteSpacing = showQuote ? (screenHeight * 0.1).clamp(40, 100) : 0;

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
