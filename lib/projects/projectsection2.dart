import 'package:flutter/material.dart';
import 'package:port_folio/projects/appCard.dart';

class Projectsec extends StatefulWidget {
  const Projectsec({super.key});

  @override
  State<Projectsec> createState() => _ProjectsecState();
}

class _ProjectsecState extends State<Projectsec> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Centering content
      children: [
        AppCard(mockupImages: [
          "assets/images/classhub.webp",
          "assets/images/Portfolio.webp",
          "assets/images/portfolion.webp"
        ])
      ],
    );
  }
}
