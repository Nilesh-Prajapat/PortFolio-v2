import 'dart:core';
import 'package:flutter/material.dart';
import 'skillcard.dart';
import 'skilsdata.dart';

class Skillsection extends StatefulWidget {
  final double dynamicSpacing;
  final double dynamicRunSpacing;
  final double cardHeight;
  final double cardWidth;
  final bool isDarkMode;

  const Skillsection({
    super.key,
    required this.dynamicSpacing,
    required this.dynamicRunSpacing,
    required this.cardHeight,
    required this.cardWidth,
    required this.isDarkMode,
  });

  @override
  State<Skillsection> createState() => _SkillsectionState();
}

class _SkillsectionState extends State<Skillsection> {
  @override
  Widget build(BuildContext context) {
    return Column(
         children: [
           Wrap(
             alignment: WrapAlignment.center,
             spacing: widget.dynamicSpacing,
             runSpacing: widget.dynamicRunSpacing,
             children: skills.map((skill) {
     return SkillCard(
       icon: skill["icon"]!,
       name: skill["name"]!,
       description: skill["description"]!,
       height: widget.cardHeight,
       width: widget.cardWidth,
       isDarkMode: widget.isDarkMode,
     );
             }).toList(),
           ),
         ],
    );
  }

}
