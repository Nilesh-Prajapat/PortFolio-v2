import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GitHubStats extends StatelessWidget {
  final String username = "nilesh-prajapat";

  const GitHubStats({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;

    // Define card width & height dynamically
    final containerWidth = (screenWidth * 0.75).clamp(230.0, 550.0);
    final containerHeight = (containerWidth * 0.4).clamp(120.0, 200.0);

    // Font size adjustments
    final baseFontSize = (screenWidth * 0.012).clamp(12.0, 18.0);
    final headingFontSize = (baseFontSize * 1.1).clamp(14.0, 24.0);
    final headingSpacing = (screenHeight * 0.02).clamp(10.0, 25.0);

    // GitHub API URLs
    final statsUrl =
        "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&theme=radical&hide_border=true";
    final streakUrl =
        "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical&hide_border=true";

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "GitHub Stats",
            style: TextStyle(
              fontSize: headingFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: headingSpacing),
          _buildGitHubWebView(statsUrl, containerWidth, containerHeight),
          SizedBox(height: headingSpacing),
          Text(
            "Current Streak",
            style: TextStyle(
              fontSize: headingFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: headingSpacing),
          _buildGitHubWebView(streakUrl, containerWidth, containerHeight),
        ],
      ),
    );
  }

  Widget _buildGitHubWebView(String url, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
          initialSettings: InAppWebViewSettings(
            useHybridComposition: true,
            allowsInlineMediaPlayback: true,
            transparentBackground: true,
            cacheEnabled: true,
            useShouldOverrideUrlLoading: false,
            disableContextMenu: true,
            supportZoom: false, // 🚫 Disable zoom
            builtInZoomControls: false, // 🚫 Remove zoom controls

          ),
        ),
      ),
    );
  }
}
