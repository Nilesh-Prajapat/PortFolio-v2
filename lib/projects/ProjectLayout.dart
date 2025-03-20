import 'package:flutter/material.dart';
import 'package:port_folio/projects/appCard.dart';
import 'package:port_folio/projects/projectCard.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Projectsec extends StatefulWidget {
  const Projectsec({super.key});

  @override
  State<Projectsec> createState() => _ProjectsecState();
}

class _ProjectsecState extends State<Projectsec> {
  int _currentIndex = 0; // Tracks the selected project

  void updateIndex(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);
    final double screenWidth = size.width;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final bool isSmallScreen = screenWidth < 850; // Breakpoint for responsiveness

    return Column(
      children: [
        SmoothPageIndicator(
          controller: PageController(initialPage: _currentIndex), // Temporary controller
          count: 3, // Adjust based on project count
          effect: ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: isDarkMode ? primaryColor : primaryColorLight,
          ),
        ),
        SizedBox(height: sectionSpacing * 0.8),

        Container(
          width: screenWidth * (isSmallScreen ? 0.95 : 0.95), // Adjust width for smaller screens
          child: isSmallScreen
              ? Column( // Use Column on smaller screens
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppCard(
                mockupImages: [
                  "assets/images/appstore.webp",
                  "assets/images/portfolioold.webp",
                  "assets/images/portfolionew.webp",
                ],
                onIndexChanged: updateIndex,
              ),
              SizedBox(height: sectionSpacing * 0.8), // Adjusted spacing
              ProjectDetailed2(currentIndex: _currentIndex),
            ],
          )
              : Row( // Use Row on larger screens
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppCard(
                mockupImages: [
                  "assets/images/classhub.webp",
                  "assets/images/Portfolio.webp",
                  "assets/images/portfolion.webp",
                ],
                onIndexChanged: updateIndex,
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: ProjectDetailed2(currentIndex: _currentIndex),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
