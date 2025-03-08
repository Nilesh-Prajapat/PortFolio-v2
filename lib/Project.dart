import 'package:flutter/material.dart';

class ProjectsSection extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {
      "title": "Portfolio App",
      "description": "A portfolio app that showcases my work."
    },
    {
      "title": "College Project App",
      "description": "Currently working on a college project app."
    },
    {
      "title": "Home Automation",
      "description": "An IoT-based home automation system."
    },
    {
      "title": "IoT Car",
      "description": "A car control system using IoT technology."
    },
    {
      "title": "Drone",
      "description": "An IoT-powered drone for various applications."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Projects",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Column(
            children: projects
                .map((project) => ProjectCard(
              title: project["title"]!,
              description: project["description"]!,
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;

  ProjectCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }
}
