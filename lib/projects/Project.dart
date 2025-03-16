import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/projects/projectsection.dart';

import '../theme/theme.dart';

class ProjectsSection extends StatelessWidget {


  ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);

    // Dynamic font sizes
    final double baseFontSize = (screenWidth * 0.013).clamp(14.0, 24.0);
    final double headingFontSize = (baseFontSize * 1.3).clamp(22.0, 42.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: sectionSpacing * 0.8,
        ),
        Text(
          "Projects",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: headingFontSize,
            color: isDarkMode ? primaryColor : primaryColorLight,
            letterSpacing: 1,
          ),
        ),
        SizedBox(
          height: sectionSpacing * 0.8,
        ),
        ProjectSec(),

      ],
    );
  }
}


