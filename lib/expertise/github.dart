import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

class GitHubStats extends StatelessWidget {
  final bool isDarkMode;
  final String username = "nilesh-prajapat";

  const GitHubStats({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final containerWidth = (screenWidth >= 850 ? (screenWidth * 0.40): (screenWidth * 0.94));
    final containerHeight =
    (containerWidth * 0.4).clamp((screenWidth >= 850 ? 168.00 : 120.00), screenHeight);

    // Font size adjustments
    final baseFontSize = (screenWidth * 0.012).clamp(12.0, 18.0);
    final headingFontSize = (baseFontSize * 1.1).clamp(16.0, 24.0);
    final headingSpacing = (screenHeight * 0.02).clamp(10.0, 25.0);

    // GitHub API URLs
    final statsUrl =
        "https://github-readme-stats.vercel.app/api?username=$username&show_icons=true&locale=en";
    final streakUrl =
        "https://github-readme-streak-stats.herokuapp.com/?user=$username&theme=radical&hide_border=true";

    // Proxy URLs (use your Vercel proxy route here)
    final proxyStatsUrl = "https://apinilesh.vercel.app/api/proxy?imageUrl=$statsUrl";
    final proxyStreakUrl = "https://apinilesh.vercel.app/api/proxy?imageUrl=$streakUrl";


    // Determine Layout: Row for small screens, Column for larger screens
    final bool isSmallScreen = screenWidth < 850;

    return Center(
      child: isSmallScreen
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStatsSection("GitHub Stats", proxyStatsUrl, containerWidth, containerHeight, headingFontSize, headingSpacing),
          SizedBox(height: headingSpacing),
          _buildStatsSection("Current Streak", proxyStreakUrl, containerWidth, containerHeight, headingFontSize, headingSpacing),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsSection("GitHub Stats", proxyStatsUrl, containerWidth, containerHeight, headingFontSize, headingSpacing),
          SizedBox(width: headingSpacing),
          _buildStatsSection("Current Streak", proxyStreakUrl, containerWidth, containerHeight, headingFontSize, headingSpacing),
        ],
      ),
    );
  }

  Widget _buildStatsSection(String title, String url, double width, double height, double fontSize, double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? primaryColor : primaryColorLight
          ),
        ),
        SizedBox(height: spacing ),
        _buildGitHubImage(url, width, height),
      ],
    );
  }

  Widget _buildGitHubImage(String url, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.network(
            url,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                      : null,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) =>
                Placeholder(
                  child: Text("Comming soon"),
                )
        ),
      ),
    );
  }
}
