import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  final List<String> skills = [
    "Flutter", "Kotlin", "Python", "HTML", "CSS",
    "JavaScript", "C", "C++", "IoT"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Skills",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: skills
                .map((skill) => Chip(
              label: Text(skill),
              backgroundColor: Colors.deepPurple.shade100,
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
