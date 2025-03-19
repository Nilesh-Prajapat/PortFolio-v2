import 'package:flutter/material.dart';
import 'package:port_folio/projects/appCard.dart';
import 'package:port_folio/projects/projectCard2.dart';

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
          SizedBox(
            height: screenHeight * 0.75, // Ensure the divider has a height
            child: VerticalDivider(
              thickness: 2,
              width: 20, // Space taken by the divider
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Flexible(child: ProjectDetailed2())
        ],
      ),
    );
  }
}
