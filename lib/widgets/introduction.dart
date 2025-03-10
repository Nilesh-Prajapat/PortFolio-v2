import 'package:flutter/material.dart';
import 'package:port_folio/aboutme.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/textParse.dart';
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
          SymbolHighlighter(
            text: "Hello, I'm",
            style: TextStyle(
              fontFamily: 'Space',
              letterSpacing: 2,
              color: isDarkMode ? Colors.white : Colors.black,
              fontSize: baseFontSize * 0.96,
            ),
            highlightColor: isDarkMode ? primaryColor : primaryColorLight,
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
          SizedBox(height: isLargeScreen ? 10 : 20), // Increased space for small screens
          Row(
            mainAxisAlignment:
            isLargeScreen ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse("https://drive.google.com/file/d/1sq5BwH0GRtKn8DqHngqEl9z1txOf8eHq/view?usp=sharing");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    debugPrint("Could not launch $url");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode ? primaryColor : primaryColorLight,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(
                    fontSize: baseFontSize * 0.9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Resume",style: TextStyle(
                    fontFamily: "Space"
                ),),
              ),

              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 400),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return FadeTransition(
                          opacity: animation,
                          child:  AboutMeEditor(),
                        );
                      },
                    ),
                  );                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: isDarkMode ? primaryColor : primaryColorLight),
                  foregroundColor: isDarkMode ? primaryColor : primaryColorLight,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: TextStyle(
                    fontSize: baseFontSize * 0.9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("About Me",style: TextStyle(
                  fontFamily: "Space"
                ),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
