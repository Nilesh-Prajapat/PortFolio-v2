import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

class ProjectDetailed2 extends StatefulWidget {
  const ProjectDetailed2({super.key});

  @override
  State<ProjectDetailed2> createState() => _ProjectDetailed2State();
}

class _ProjectDetailed2State extends State<ProjectDetailed2> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color containerColor = isDarkMode ? Colors.black : Colors.white70;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double containerHeight = screenHeight * 0.75;

    return Center(
      child: Container(
        height: containerHeight,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20), // Rounded edges
          boxShadow: [
            BoxShadow(
              color: primaryColor,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            "Project Details",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
