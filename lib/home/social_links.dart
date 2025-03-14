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
    final textStyle = GoogleFonts.spaceMono(
      fontSize: (iconSize * 0.6).clamp(12.0, 20.0),
      color: isDarkMode ? darkTextColor : lightTextColor,
    );

    final EdgeInsets itemPadding = EdgeInsets.only(bottom: screenWidth * 0.01);
    final double wrapSpacing = screenWidth * 0.05;

    final socialItems = [
      SocialItem(
        icon: "assets/icon/github.png",
        url: "https://github.com/Nilesh-Prajapat",
        name: "github.com/Nilesh-Prajapat",
        iconSize: iconSize,
        textStyle: textStyle,
        isLargeScreen: isLargeScreen,
        isDarkMode: isDarkMode,
      ),
      SocialItem(
        icon: "assets/icon/instagram.png",
        url: "https://instagram.com/Its.nilesh_pr",
        name: "instagram.com/Its.nilesh_pr",
        iconSize: iconSize,
        textStyle: textStyle,
        isLargeScreen: isLargeScreen,
        isDarkMode: isDarkMode,
      ),
      SocialItem(
        icon: "assets/icon/linked.png",
        url: "https://linkedin.com/in/nilesh-prajapat",
        name: "linkedin.com/Nilesh-Prajapat",
        iconSize: iconSize,
        textStyle: textStyle,
        isLargeScreen: isLargeScreen,
        isDarkMode: isDarkMode,
      ),
    ];

    return isLargeScreen
        ? Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: socialItems
          .map((item) => Padding(padding: itemPadding, child: item))
          .toList(),
    )
        : Wrap(
      spacing: wrapSpacing,
      children: socialItems,
    );
  }
}

class SocialItem extends StatelessWidget {
  final String icon;
  final String url;
  final String name;
  final double iconSize;
  final TextStyle textStyle;
  final bool isLargeScreen;
  final bool isDarkMode;

  const SocialItem({
    super.key,
    required this.icon,
    required this.url,
    required this.name,
    required this.iconSize,
    required this.textStyle,
    required this.isLargeScreen,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } else {
          debugPrint("Could not launch $url");
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
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
