import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:port_folio/projects/ProjectData.dart'; // Import project lists

class ProjectDetailed2 extends StatefulWidget {
  final int currentIndex;

  const ProjectDetailed2({super.key, required this.currentIndex});

  @override
  State<ProjectDetailed2> createState() => _ProjectDetailed2State();
}

class _ProjectDetailed2State extends State<ProjectDetailed2> {
  bool _isVisible = false; // Track visibility
  bool _isAnimationComplete = false; // Track if animation is finished

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color containerColor = isDarkMode ? Colors.black : Colors.white;
    final Color titleColor = isDarkMode ? primaryColor : primaryColorLight;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isSmallScreen = screenWidth < 850;

    final double minHeight = isSmallScreen
        ? 300.0 // Fixed minHeight for small screens
        : (screenHeight * 0.7).clamp(300.0, 630.0); // Large screens

    final double titleFontSize = isSmallScreen ? 18 : 24;
    final double descriptionFontSize = isSmallScreen ? 14 : 18;

    // Select project list based on screen size
    List<Map<String, dynamic>> projectList = screenWidth > 1000
        ? projectsLarge
        : screenWidth > 850
        ? projectsMedium
        : projectsSmall;

    final project = projectList[widget.currentIndex % projectList.length];

    return VisibilityDetector(
      key: ValueKey("project_${widget.currentIndex}"), // Unique key
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.2) {
          setState(() {
            _isVisible = true;
          });
        } else {
          setState(() {
            _isVisible = false;
            _isAnimationComplete = false; // Reset animation state if not visible
          });
        }
      },
      child: Center(
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(minHeight: minHeight), // Fixed minHeight for all screens
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: titleColor,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Project Title
              Text(
                project['title'],
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                  color: titleColor,
                ),
              ),
              const SizedBox(height: 15),

              // Description Animation
              if (_isVisible)
                AnimatedTextKit(
                  key: ValueKey(widget.currentIndex),
                  animatedTexts: [
                    TypewriterAnimatedText(
                      project['description'],
                      textStyle: TextStyle(
                        fontSize: descriptionFontSize,
                        fontWeight: FontWeight.w500,
                      ),
                      speed: const Duration(milliseconds: 20),
                    ),
                  ],
                  repeatForever: false,
                  totalRepeatCount: 1,
                  onFinished: () {
                    setState(() {
                      _isAnimationComplete = true; // Mark animation as complete
                    });
                  },
                ),

              const SizedBox(height: 15),

              // GitHub Link - Appears after animation completes
              if (_isAnimationComplete)
                GestureDetector(
                  onTap: () async {
                    final String githubUrl = project['github'] ?? '';
                    if (githubUrl.isNotEmpty) {
                      final Uri url = Uri.parse(githubUrl);
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Could not open GitHub link")),
                        );
                      }
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.code, color: titleColor),
                      const SizedBox(width: 8),
                      Text(
                        "Check out on GitHub – Tap",
                        style: TextStyle(
                          fontSize: descriptionFontSize,
                          fontWeight: FontWeight.w600,
                          color: titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
