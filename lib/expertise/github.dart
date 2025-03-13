import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GitHubStats extends StatelessWidget {
  final String username = "nilesh-prajapat";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define card width & height (keeping the same size)
    double containerWidth = (screenWidth * 0.75).clamp(230, 550);
    double containerHeight = (containerWidth * 0.4).clamp(120, 200);

    // Font size adjustments
    double baseFontSize = (screenWidth * 0.012).clamp(12, 18);
    double headingFontSize = (baseFontSize * 1.1).clamp(14, 24);

    // Spacing adjustments
    double headingSpacing = (screenHeight * 0.02).clamp(10, 25);

    // GitHub API URLs
    String statsUrl = "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&theme=radical";
    String streakUrl = "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical";

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
    return ClipRect(

      child: SizedBox( // Ensures the container only takes the necessary size
        width: width,
        height: height,
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri(url)),
        ),
      ),
    );
  }
}
