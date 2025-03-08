import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Contact Me",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.email),
                color: Colors.deepPurple,
                onPressed: () {
                  // Handle email action
                },
              ),
              IconButton(
                icon: Icon(Icons.linked_camera), // Example LinkedIn icon
                color: Colors.deepPurple,
                onPressed: () {
                  // Handle LinkedIn link
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_camera), // Example Instagram icon
                color: Colors.deepPurple,
                onPressed: () {
                  // Handle Instagram link
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
