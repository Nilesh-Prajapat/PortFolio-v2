import 'package:flutter/material.dart';
import 'package:port_folio/expertise/skillsection.dart';
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

class _SkillsPageState extends State<SkillsPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive =>
      true; // Prevents widget from rebuilding unnecessarily

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin

    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Dynamic font sizes
    final double baseFontSize = (screenWidth * 0.013).clamp(12.0, 24.0);
    final double headingFontSize = (baseFontSize * 1.3).clamp(22.0, 42.0);

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

    return Column(
      children: [
        if (screenWidth < 850) SizedBox(height: sectionSpacing / 2),
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
        SizedBox(height: sectionSpacing * 0.8 ),
        if (screenWidth >= 850)
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: screenWidth * 0.008),
                child: Skillsection(
                  dynamicSpacing: dynamicSpacing,
                  dynamicRunSpacing: dynamicRunSpacing,
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: sectionSpacing * 0.8 ),
              GitHubStats(isDarkMode: isDarkMode,),
              SizedBox(height: sectionSpacing * 0.8),

            ],
          )
        else
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Skillsection(
                  dynamicSpacing: dynamicSpacing,
                  dynamicRunSpacing: dynamicRunSpacing,
                  cardHeight: cardHeight,
                  cardWidth: cardWidth,
                  isDarkMode: isDarkMode,
                ),
              ),
              SizedBox(height: skillGitHubSpacing),
              GitHubStats(isDarkMode: isDarkMode,),
              SizedBox(height: skillGitHubSpacing),
            ],
          ),
      ],
    );
  }
}
