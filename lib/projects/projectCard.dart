import 'package:flutter/material.dart';

class ProjectDetailed2 extends StatefulWidget {
  const ProjectDetailed2({super.key});

  @override
  State<ProjectDetailed2> createState() => _ProjectDetailed2State();
}

class _ProjectDetailed2State extends State<ProjectDetailed2> {
  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color containerColor = isDarkMode ? Colors.white10 : Colors.white70;

    return Center(
      child: Container(

        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(20), // Rounded edges
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
