import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Breakpoints
const double mobileWidth = 850;
const double appBarHeight = kToolbarHeight;

class Utils {
  // **Theme & Screen Size Helpers**
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size size(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double width(BuildContext context) {
    return size(context).width;
  }

  static double height(BuildContext context) {
    return size(context).height;
  }

  // **Typography Helpers**
  static double baseFontSize(BuildContext context) {
    double screenWidth = width(context);
    return (screenWidth * (screenWidth > mobileWidth ? 0.015 : 0.042))
        .clamp(14.0, 26.0);
  }

  static double nameFontSize(BuildContext context) {
    return (baseFontSize(context) * 1.5).clamp(18.0, 36.0);
  }

  static double h2TextFontSize(BuildContext context) {
    return (baseFontSize(context) * 1.2).clamp(16.0, 28.0);
  }

  static double buttonFontSize(BuildContext context) {
    return baseFontSize(context) * 0.9;
  }

  static double heading(BuildContext context) {
    double w = width(context);
    return w < mobileWidth
        ? (w * 0.045).clamp(14, 24)
        : (w * 0.02).clamp(16, 28);
  }

  static double navItems(BuildContext context) {
    double w = width(context);
    return w < mobileWidth
        ? (w * 0.035).clamp(12, 18)
        : (w * 0.013).clamp(13, 18);
  }

  // **Avatar & Container Helpers**
  static double avatarSize(BuildContext context) {
    double w = width(context);
    return w > mobileWidth
        ? (w * 0.15).clamp(150.0, 300.0)
        : (w * 0.32).clamp(80.0, 180.0);
  }

  static double containerWidth(BuildContext context) {
    double w = width(context);
    return w > mobileWidth
        ? (w * 0.85).clamp(600, 850)
        : (w * 0.85).clamp(300, 550);
  }

  static double containerHeight(BuildContext context) {
    return width(context) > mobileWidth ? 350 : 300;
  }

  static double responsiveSpacing(BuildContext context) {
    return width(context) > mobileWidth ? 40 : 80;
  }

  // **Social Media Icon Helpers**
  static double socialIconSize(BuildContext context) {
    double screenWidth = width(context);
    return (screenWidth * (screenWidth < mobileWidth ? 0.072 : 0.025))
        .clamp(24.0, 45.0);
  }

  static double socialTextSize(BuildContext context) {
    return (socialIconSize(context) * 0.6).clamp(12.0, 20.0);
  }

  // **GitHub Cards Helpers**
  static double baseFontSize2(BuildContext context) {
    return (width(context) * 0.013).clamp(12.0, 24.0);
  }

  static double headingFontSize(BuildContext context) {
    return (baseFontSize2(context) * 1.3).clamp(22.0, 42.0);
  }

  static int cardsPerRow(BuildContext context) {
    double w = width(context);
    return w > 1100 ? 6 : w > 900 ? 5 : w > 700 ? 4 : 3;
  }

  static double cardWidth(BuildContext context) {
    double w = width(context);
    double cardSize = (w / (cardsPerRow(context) + 0.5)) * 0.85;
    return cardSize.clamp(90, 150);
  }

  static double cardHeight(BuildContext context) {
    return (cardWidth(context) * 0.75).clamp(80, 120);
  }

  // **Spacing Helpers**
  static double sectionSpacing(BuildContext context) {
    return (height(context) * 0.06).clamp(30, 90);
  }

  static double skillGitHubSpacing(BuildContext context) {
    return (height(context) * 0.03).clamp(14, 35);
  }

  static double dynamicSpacing(BuildContext context) {
    return (width(context) * 0.02).clamp(10, 30);
  }

  static double dynamicRunSpacing(BuildContext context) {
    return (width(context) * 0.025).clamp(12, 32);
  }

  // **Utility Functions**
  static Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.platformDefault);
    } else {
      debugPrint("Could not launch $uri");
    }
  }
  static double githubContainerWidth(BuildContext context) {
    double w = width(context);
    return (w * 0.4).clamp(365, 600);
  }

  static double githubContainerHeight(BuildContext context) {
    return (githubContainerWidth(context) * 0.5).clamp(200, 320);
  }

  static double githubHeadingFontSize(BuildContext context) {
    double w = width(context);
    return (w * 0.012 * 1.1).clamp(16, 24);
  }

  static double githubHeadingSpacing(BuildContext context) {
    return (MediaQuery.of(context).size.height * 0.02).clamp(12, 25);
  }


//   for skilldetaild
static double skillcontainerw (BuildContext context){
    double w = width(context);
    return  (w * 0.85).clamp(300, 850);

}
  static double skillcontainerh (BuildContext context){
    double h = height(context);
    return  h * 0.5;
  }

}
