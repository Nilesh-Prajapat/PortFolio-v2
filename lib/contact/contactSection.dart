import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/home/social_links.dart';

import '../theme/theme.dart';

class contactSection extends StatefulWidget {
  const contactSection({super.key});

  @override
  State<contactSection> createState() => _contactSectionState();
}

class _contactSectionState extends State<contactSection> {
  @override
  Widget build(BuildContext context) {
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
final bool  isLargeScreen = screenWidth >= 850;
    // Dynamic spacing
    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);
    final double skillGitHubSpacing = (screenHeight * 0.03).clamp(14, 35);
    final double dynamicSpacing = (screenWidth * 0.02).clamp(10, 30);
    final double dynamicRunSpacing = (screenWidth * 0.025).clamp(12, 32);
    final double iconSize =
    (screenWidth * (isLargeScreen ? 0.025 : 0.072)).clamp(24.0, 45.0);

    final TextStyle textStyle = GoogleFonts.spaceMono(
      fontSize: (iconSize * 0.6).clamp(12.0, 20.0),
      color: isDarkMode ? darkTextColor : lightTextColor,
    );
    return Container(
      child: Padding(
        padding:  EdgeInsets.all(screenWidth>= 850 ? 16.0:0.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Contact Me",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: headingFontSize,
                letterSpacing: 1,
                color: isDarkMode ? primaryColor : primaryColorLight,
              ),
            ),
            SizedBox(
              height: sectionSpacing * 0.8,
            ),
            Text("Have a bold idea or an ambitious project in mind?\n\n"
                "Reach out, and let’s create something extraordinary!",style: textStyle,),
            SizedBox(
              height: sectionSpacing *3,
            ),
            SocialLinksWidget(isLargeScreen: isLargeScreen, screenWidth: screenWidth, isDarkMode: isDarkMode)
          ],
        ),
      ),
    );
  }
}
