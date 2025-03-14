import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:port_folio/aboutme.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/textParse.dart';
import 'social_links.dart';

class IntroWidget extends StatelessWidget {
  final double screenWidth;
  final bool isLargeScreen;

  const IntroWidget({
    super.key,
    required this.screenWidth,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double baseFontSize = (screenWidth * (isLargeScreen ? 0.015 : 0.042)).clamp(14.0, 26.0);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: isLargeScreen ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SymbolHighlighter(
            text: "Hello, I'm",
            style: GoogleFonts.spaceMono(
              letterSpacing: 2,
              color: isDarkMode ? darkTextColor : lightTextColor,
              fontSize: baseFontSize * 0.96,
            ),
            highlightColor: isDarkMode ? primaryColor : primaryColorLight,
          ),
          const SizedBox(height: 5),
          Text(
            "Nilesh Prajapat",
            style: GoogleFonts.spaceMono(
              letterSpacing: 1,
              color: isDarkMode ? darkTextColor : lightTextColor,
              fontSize: (baseFontSize * 1.5).clamp(18.0, 36.0),
              fontWeight: FontWeight.bold,
            ),
            textAlign: isLargeScreen ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 5),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                TypewriterAnimatedText(
                  'App Developer',
                  speed: const Duration(milliseconds: 100),
                  textStyle: GoogleFonts.spaceMono(
                    color: isDarkMode ? primaryColor : primaryColorLight,
                    letterSpacing: 1,
                    fontSize: (baseFontSize * 1.2).clamp(16.0, 28.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'Student',
                  speed: const Duration(milliseconds: 100),
                  textStyle: GoogleFonts.spaceMono(
                    color: isDarkMode ? primaryColor : primaryColorLight,
                    letterSpacing: 1,
                    fontSize: (baseFontSize * 1.2).clamp(16.0, 28.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'Gamer',
                  speed: const Duration(milliseconds: 100),
                  textStyle: GoogleFonts.spaceMono(
                    color: isDarkMode ? primaryColor : primaryColorLight,
                    letterSpacing: 1,
                    fontSize: (baseFontSize * 1.2).clamp(16.0, 28.0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SocialLinksWidget(
            isLargeScreen: isLargeScreen,
            screenWidth: screenWidth,
            isDarkMode: isDarkMode,
          ),
          SizedBox(height: isLargeScreen ? 10 : 20),
          Row(
            mainAxisAlignment: isLargeScreen ? MainAxisAlignment.start : MainAxisAlignment.center,
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
                  textStyle: GoogleFonts.spaceMono(
                    fontSize: baseFontSize * 0.9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Resume"),
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
                          child: AboutMeEditor(),
                        );
                      },
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: isDarkMode ? primaryColor : primaryColorLight),
                  foregroundColor: isDarkMode ? primaryColor : primaryColorLight,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: GoogleFonts.spaceMono(
                    fontSize: baseFontSize * 0.9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("About Me"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
