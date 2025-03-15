import 'package:flutter/material.dart';
import 'ProjectData.dart';
import 'projectCard.dart';

class ProjectSec extends StatefulWidget {
  const ProjectSec({super.key});

  @override
  State<ProjectSec> createState() => _ProjectSecState();
}

class _ProjectSecState extends State<ProjectSec> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;

    // Select project list based on screen width
    final projectList = screenWidth >= 1050
        ? projects // Large screens (Desktop)
        : screenWidth >= 850
        ? projectsMedium // Medium screens (Tablets)
        : projectsm; // Small screens (Mobile)

    return SizedBox(
      width: screenWidth * 0.98,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(projectList.length, (index) {
          return ProjectCard(
            title: projectList[index]["title"]!,
            description: projectList[index]["description"]!,
            width: screenWidth,
            imageFirst: projectList[index]["imageFirst"],
            imageUrl: projectList[index]["image"],
            githubUrl: projectList[index]["github"],
          );
        }),
      ),
    );
  }
}
