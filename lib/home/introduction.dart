import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/home/aboutmedata.dart';
import 'package:port_folio/utils/popup.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/LayoutConstraints.dart';
import 'package:port_folio/utils/textParse.dart';
import 'social_links.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Utils.isDarkMode(context);
    final double screenWidth = Utils.width(context);
    final bool isLargeScreen = screenWidth > mobileWidth;
    final size = Utils.size(context);
    final containerWidth = Utils.containerWidth(context);

    // Center the window
    final xPos = (size.width - containerWidth) / 2;
    final yPos = size.height / 10;

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
            style: GoogleFonts.spaceMono(
              letterSpacing: 2,
              color: isDarkMode ? darkTextColor : lightTextColor,
              fontSize: Utils.baseFontSize(context) * 0.96,
            ),
            highlightColor: isDarkMode ? primaryColor : primaryColorLight,
          ),
          const SizedBox(height: 5),
          Text(
            "Nilesh Prajapat",
            style: GoogleFonts.spaceMono(
              letterSpacing: 1,
              color: isDarkMode ? darkTextColor : lightTextColor,
              fontSize: Utils.nameFontSize(context),
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
                    fontSize: Utils.h2TextFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'Student',
                  speed: const Duration(milliseconds: 100),
                  textStyle: GoogleFonts.spaceMono(
                    color: isDarkMode ? primaryColor : primaryColorLight,
                    letterSpacing: 1,
                    fontSize: Utils.h2TextFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'Gamer',
                  speed: const Duration(milliseconds: 100),
                  textStyle: GoogleFonts.spaceMono(
                    color: isDarkMode ? primaryColor : primaryColorLight,
                    letterSpacing: 1,
                    fontSize: Utils.h2TextFontSize(context),
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
            mainAxisAlignment: isLargeScreen
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final Uri url = Uri.parse(
                      "https://drive.google.com/file/d/1sq5BwH0GRtKn8DqHngqEl9z1txOf8eHq/view?usp=sharing");
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    debugPrint("Could not launch $url");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode ? primaryColor : primaryColorLight,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: GoogleFonts.spaceMono(
                    fontSize: Utils.buttonFontSize(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Resume"),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Popup(
                            discription: isLargeScreen
                                ? fullAboutMeText
                                : shortAboutMeText,
                            icon: Icons.description,
                            title: "about_me",
                            popupType: "aboutMe",
                            containerWidth: containerWidth,
                            xPos: xPos,
                            yPos: yPos,
                            lock: 1.2);
                      });
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: isDarkMode ? primaryColor : primaryColorLight),
                  foregroundColor:
                      isDarkMode ? primaryColor : primaryColorLight,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  textStyle: GoogleFonts.spaceMono(
                    fontSize: Utils.buttonFontSize(context),
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
