import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'social_links.dart';

class IntroWidget extends StatelessWidget {
  final double screenWidth;
  final bool isLargeScreen;
  final bool isDarkMode;

  const IntroWidget({
    super.key,
    required this.screenWidth,
    required this.isLargeScreen,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {



    double baseFontSize = (screenWidth * (isLargeScreen ? 0.015 : 0.042))
        .clamp(14.0, 26.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isLargeScreen
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Text(
            "Hello, I'm",
            style: TextStyle(
              fontFamily: 'Space',
              letterSpacing: 2,
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: baseFontSize * 0.96,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            "Nilesh Prajapat",
            style: TextStyle(
              fontFamily: 'Space',
              letterSpacing: 1,
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: (baseFontSize * 1.5).clamp(18.0, 36.0),
              fontWeight: FontWeight.bold,
            ),
            textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            "App Developer / Student",
            style: TextStyle(
              fontFamily: 'Space',
              color: isDarkMode ? primaryColor : primaryColorLight,
              letterSpacing: 1,
              fontSize: (baseFontSize * 1.2).clamp(16.0, 28.0),
              fontWeight: FontWeight.bold,
            ),
            textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 10),
          SocialLinksWidget(
            isLargeScreen: isLargeScreen,
            screenWidth: screenWidth,
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
}
