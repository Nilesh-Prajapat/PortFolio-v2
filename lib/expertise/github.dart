import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GitHubStats extends StatelessWidget {
  final String username = "nilesh-prajapat";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust card width & height based on screen width
    double containerWidth;
    double containerHeight;

    if (screenWidth > 850) {
      // For large screens, increase the card size
      containerWidth = (screenWidth * 0.4).clamp(300, 600);  // Increase width for large screens
    } else {
      // For small screens, use 90% of the screen width
      containerWidth = (screenWidth * 0.98); // Set a 90% width for small screens
    }

    // Adjust height proportionally to width
    containerHeight = (containerWidth * 0.45).clamp(150, 300);

    double baseFontSize = (screenWidth * 0.012).clamp(12, 18);
    double headingFontSize = (baseFontSize * 1.1).clamp(14, 24);

    double headingSpacing = (screenHeight * 0.02).clamp(10, 25);

    String statsUrl = "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&theme=radical";
    String streakUrl = "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical";

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 850;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Pass dynamic titles, spacing, and font size to the view functions
              isWideScreen
                  ? _buildGridView(
                  statsUrl, streakUrl, containerWidth, containerHeight,
                  "GitHub Stats", "GitHub Streak", headingSpacing, headingFontSize)
                  : _buildColumnView(
                  statsUrl, streakUrl, containerWidth, containerHeight,
                  "GitHub Stats", "GitHub Streak", headingSpacing, headingFontSize),
            ],
          );
        },
      ),
    );
  }

  // Widget for showing stats and streak in a GridView (Horizontal Layout for Wide Screens)
  Widget _buildGridView(String statsUrl, String streakUrl, double width, double height,
      String title1, String title2, double headingSpacing, double headingFontSize) {
    return Container(
      width: width * 2, // Ensuring there's enough space for both cards
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: _buildGitHubWebView(
                statsUrl, width, height, title1, headingSpacing, headingFontSize),
          ),
          SizedBox(width: 10),
          Flexible(
            child: _buildGitHubWebView(
                streakUrl, width, height, title2, headingSpacing, headingFontSize),
          ),
        ],
      ),
    );
  }

  // Widget for showing stats and streak in a Column (Vertical Layout for Narrow Screens)
  Widget _buildColumnView(String statsUrl, String streakUrl, double width, double height,
      String title1, String title2, double headingSpacing, double headingFontSize) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGitHubWebView(
            statsUrl, width, height, title1, headingSpacing, headingFontSize),
        SizedBox(height: 10),
        _buildGitHubWebView(
            streakUrl, width, height, title2, headingSpacing, headingFontSize),
      ],
    );
  }

  // WebView widget with dynamic title, heading spacing, and heading font size
  Widget _buildGitHubWebView(String url, double width, double height,
      String title, double headingSpacing, double headingFontSize) {
    return ClipRect(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(height: headingSpacing),
            Text(
              title,  // Use the passed dynamic title here
              style: TextStyle(
                fontSize: headingFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: headingSpacing),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(url)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
