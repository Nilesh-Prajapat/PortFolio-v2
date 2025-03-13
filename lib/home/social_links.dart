import 'package:flutter/material.dart';
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
    double iconSize =
        (screenWidth * (isLargeScreen ? 0.025 : 0.072)).clamp(24.0, 45.0);
    final textStyle = TextStyle(
      fontSize: (iconSize * 0.6).clamp(12.0, 20.0),
      color: isDarkMode ? darkTextColor :lightTextColor,
      fontFamily: "Space",
    );

    final socialItems = [
      _socialItem(
          "assets/icon/github.png",
          "https://github.com/Nilesh-Prajapat",
          "github.com/Nilesh-Prajapat",
          iconSize,
          textStyle),
      _socialItem(
          "assets/icon/instagram.png",
          "https://instagram.com/Its.nilesh_pr",
          "instagram.com/Its.nilesh_pr",
          iconSize,
          textStyle),
      _socialItem(
          "assets/icon/linked.png",
          "https://linkedin.com/in/nilesh-prajapat",
          "linkedin.com/Nilesh-Prajapat",
          iconSize,
          textStyle),
    ];

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

  Widget _socialItem(String icon, String url, String name, double iconSize,
      TextStyle textStyle) {
    return GestureDetector(
      onTap: () async {
        Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.platformDefault);
        } else {
          print("Could not launch $url");
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
