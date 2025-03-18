import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GitHubStats extends StatelessWidget {
  final String username = "nilesh-prajapat";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Hide GitHub stats completely for screens below 850 pixels
    if (screenWidth < 850) {
      return SizedBox.shrink();
    }

    double containerWidth = (screenWidth * 0.4).clamp(365, 600); // Increased min width to 350
    double containerHeight = (containerWidth * 0.5).clamp(200, 320); // Increased min height to 180
    double headingFontSize = (screenWidth * 0.012 * 1.1).clamp(16, 24);
    double headingSpacing = (MediaQuery.of(context).size.height * 0.02).clamp(12, 25);

    String statsUrl = "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&theme=radical";
    String streakUrl = "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical";

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGitHubWebView(statsUrl, containerWidth, containerHeight, "GitHub Stats", headingSpacing, headingFontSize),
          SizedBox(width: 12),
          _buildGitHubWebView(streakUrl, containerWidth, containerHeight, "GitHub Streak", headingSpacing, headingFontSize),
        ],
      ),
    );
  }

  // WebView widget with dynamic title
  Widget _buildGitHubWebView(String url, double width, double height, String title, double headingSpacing, double headingFontSize) {
    return ClipRect(
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          children: [
            SizedBox(height: headingSpacing),
            Text(
              title,
              style: TextStyle(fontSize: headingFontSize, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: headingSpacing),
            Expanded(
              child: Stack(
                children: [
                  InAppWebView(
                    initialUrlRequest: URLRequest(url: WebUri(url)),
                  ),
                  Positioned.fill(
                    child: AbsorbPointer(
                      child: Container(
                        color: Colors.transparent, // Transparent overlay blocking interactions
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
