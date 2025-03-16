import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:port_folio/theme/theme.dart';

class GitHubStats extends StatefulWidget {
  final bool isDarkMode;
  final String username = "nilesh-prajapat";

  const GitHubStats({Key? key, required this.isDarkMode}) : super(key: key);

  @override
  _GitHubStatsState createState() => _GitHubStatsState();
}

class _GitHubStatsState extends State<GitHubStats> {
  late String statsUrl;
  late String streakUrl;
  late String proxyStatsUrl;
  late String proxyStreakUrl;

  late Future<Uint8List> statsImage;
  late Future<Uint8List> streakImage;

  @override
  void initState() {
    super.initState();

    statsUrl = "https://github-readme-stats.vercel.app/api?username=${widget.username}&show_icons=true&locale=en";
    streakUrl = "https://github-readme-streak-stats.herokuapp.com/?user=${widget.username}&theme=radical&hide_border=true";

    proxyStatsUrl = "https://apinilesh.vercel.app/api/proxy?imageUrl=$statsUrl";
    proxyStreakUrl = "https://apinilesh.vercel.app/api/proxy?imageUrl=$streakUrl";

    // Fetch the images
    statsImage = fetchImage(proxyStatsUrl);
    streakImage = fetchImage(proxyStreakUrl);
  }

  Future<Uint8List> fetchImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Adjust container width and height based on screen size
    final containerWidth = (screenWidth >= 850 ? (screenWidth * 0.40) : (screenWidth * 0.94));
    final containerHeight = (containerWidth * 0.4).clamp((screenWidth >= 850 ? 168.00 : 120.00), screenHeight);

    // Font size adjustments
    final baseFontSize = (screenWidth * 0.012).clamp(12.0, 18.0);
    final headingFontSize = (baseFontSize * 1.1).clamp(16.0, 24.0);
    final headingSpacing = (screenHeight * 0.02).clamp(10.0, 25.0);

    // Determine Layout: Row for large screens, Column for small screens
    final bool isSmallScreen = screenWidth < 850;

    return Center(
      child: isSmallScreen
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildStatsSection("GitHub Stats", statsImage, containerWidth, containerHeight, headingFontSize, headingSpacing),
          SizedBox(height: headingSpacing),
          _buildStatsSection("Current Streak", streakImage, containerWidth, containerHeight, headingFontSize, headingSpacing),
        ],
      )
          : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsSection("GitHub Stats", statsImage, containerWidth, containerHeight, headingFontSize, headingSpacing),
          SizedBox(width: headingSpacing),
          _buildStatsSection("Current Streak", streakImage, containerWidth, containerHeight, headingFontSize, headingSpacing),
        ],
      ),
    );
  }

  // Reusable method for stats sections
  Widget _buildStatsSection(String title, Future<Uint8List> image, double width, double height, double fontSize, double spacing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? primaryColor : primaryColorLight
          ),
        ),
        SizedBox(height: spacing),
        FutureBuilder<Uint8List>(
          future: image,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Icon(Icons.error, color: widget.isDarkMode ? Colors.white : Colors.black, size: 40));
            } else if (snapshot.hasData) {
              return _buildGitHubImage(snapshot.data!, width, height);
            } else {
              return Center(child: Text('Failed to load image.'));
            }
          },
        ),
      ],
    );
  }

  // Reusable method for displaying GitHub image
  Widget _buildGitHubImage(Uint8List imageData, double width, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: width,
        height: height,
        child: Image.memory(
          imageData,
          fit: BoxFit.contain, // Keeps the aspect ratio while adjusting size
        ),
      ),
    );
  }
}
