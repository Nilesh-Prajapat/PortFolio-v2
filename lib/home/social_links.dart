import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/textParse.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinksWidget extends StatelessWidget {
  final bool isLargeScreen;
  final double screenWidth;
  final bool isDarkMode;

  const SocialLinksWidget({
    super.key,
    required this.isLargeScreen,
    required this.screenWidth,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize =
    (screenWidth * (isLargeScreen ? 0.025 : 0.072)).clamp(24.0, 45.0);

    final TextStyle textStyle = GoogleFonts.spaceMono(
      fontSize: (iconSize * 0.6).clamp(12.0, 20.0),
      color: isDarkMode ? darkTextColor : lightTextColor,
    );

    final List<Map<String, String>> socialData = [
      {
        "icon": "assets/icon/github.png",
        "url": "https://github.com/Nilesh-Prajapat",
        "name": "github.com/Nilesh-Prajapat"
      },
      {
        "icon": "assets/icon/instagram.png",
        "url": "https://instagram.com/Its.nilesh_pr",
        "name": "instagram.com/Its.nilesh_pr"
      },
      {
        "icon": "assets/icon/linked.png",
        "url": "https://linkedin.com/in/nilesh-prajapat",
        "name": "linkedin.com/Nilesh-Prajapat"
      },
    ];

    final List<Widget> socialItems = socialData.map((data) {
      return _socialItem(
        data["icon"]!,
        Uri.parse(data["url"]!),
        data["name"]!,
        iconSize,
        textStyle,
      );
    }).toList();

    return isLargeScreen
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: socialItems
          .map((item) => Padding(
        padding: EdgeInsets.only(bottom: screenWidth * 0.01),
        child: item,
      ))
          .toList(),
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialItems
          .map((item) => Padding(
        padding: EdgeInsets.only(right: screenWidth * 0.05),
        child: item,
      ))
          .toList(),
    );
  }

  Widget _socialItem(String icon, Uri uri, String name, double iconSize, TextStyle textStyle) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } else {
          debugPrint("Could not launch $uri");
        }
      },
      child: Row(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: iconSize,
            color: isDarkMode ? primaryColor : primaryColorLight,
          ),
          if (isLargeScreen) ...[
            SizedBox(width: iconSize * 0.5),
            SymbolHighlighter(
              text: name,
              style: textStyle,
              highlightColor: isDarkMode ? primaryColor : primaryColorLight,
            ),
          ],
        ],
      ),
    );
  }
}
