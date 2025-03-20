import 'package:flutter/material.dart';
import 'package:port_folio/projects/appCard.dart';
import 'package:port_folio/projects/projectCard.dart';

class Projectsec extends StatefulWidget {
  const Projectsec({super.key});

  @override
  State<Projectsec> createState() => _ProjectsecState();
}

class _ProjectsecState extends State<Projectsec> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: screenWidth * 0.95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Centering content
        children: [
          AppCard(mockupImages: [
            "assets/images/Portfolio.webp",
            "assets/images/portfolion.webp",
                "assets/images/Portfolio.webp",
          ]),
          SizedBox(width: screenWidth * 0.02),
          Flexible(child: ProjectDetailed2())
        ],
      ),
    );
  }
}
