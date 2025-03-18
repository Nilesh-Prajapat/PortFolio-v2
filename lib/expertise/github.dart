import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GitHubStats extends StatelessWidget {
  final String username = "nilesh-prajapat";

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < 850) {
      return SizedBox.shrink();
    }

    double containerWidth = (screenWidth * 0.45).clamp(400, 650);
    double containerHeight = (containerWidth * 0.55).clamp(220, 350);
    double headingFontSize = (screenWidth * 0.013 * 1.1).clamp(18, 26);
    double headingSpacing = (MediaQuery.of(context).size.height * 0.025).clamp(14, 30);

    String statsUrl = "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&theme=radical&format=png";
    String streakUrl = "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical&format=png";

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGitHubWebView(statsUrl, containerWidth, containerHeight, "GitHub Stats", headingSpacing, headingFontSize),
          SizedBox(width: 16),
          _buildGitHubWebView(streakUrl, containerWidth, containerHeight, "GitHub Streak", headingSpacing, headingFontSize),
        ],
      ),
    );
  }

  // WebView widget with embedded HTML instead of URL
  Widget _buildGitHubWebView(String imageUrl, double width, double height, String title, double headingSpacing, double headingFontSize) {
    String htmlContent = '''
      <html>
      <head>
        <style>
          body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: transparent;
            overflow: hidden;
            user-select: none;
          }
          img {
            width: 105%;
            height: 105%;
            object-fit: contain;
            pointer-events: none;
          }
        </style>
      </head>
      <body>
        <img src="$imageUrl" alt="$title" />
      </body>
      </html>
    ''';

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
              child: IgnorePointer( // Prevents WebView from interfering with scrolling
                child: InAppWebView(
                  initialData: InAppWebViewInitialData(data: htmlContent),
                  gestureRecognizers: {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
