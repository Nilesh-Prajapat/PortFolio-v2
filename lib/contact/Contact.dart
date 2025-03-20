import 'package:flutter/material.dart';
import 'package:port_folio/contact/contactSection.dart';
import 'package:port_folio/contact/formSection.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final double sectionSpacing = (screenHeight * 0.06).clamp(30, 90);

    return Center(
      child: Container(
        padding: EdgeInsets.only(top: sectionSpacing * 0.8,bottom: sectionSpacing *0.3),

        constraints: BoxConstraints(minHeight: screenHeight-kToolbarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Main Content
            Container(
              width: screenWidth * 0.9,
              child: screenWidth >= 850
                  ? IntrinsicHeight( // Ensures children match the tallest widget
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch, // Make items stretch vertically
                  children: [
                    Flexible(child: contactSection()),
                    SizedBox(width: sectionSpacing * 0.5),
                    SizedBox(
                      width: 2, // Divider thickness
                      child: VerticalDivider(
                        thickness: 2,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: sectionSpacing * 0.5),
                    Flexible(child: FormSection()),
                  ],
                ),
              )
                  : FormSection(),
            ),

            // Footer Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 12),
              color: isDarkMode ? Colors.black : Colors.grey[200],
              child: Center(
                child: Text(
                  "© 2025 Made by Nilesh Prajapat | Built with Flutter",
                  style: TextStyle(
                    fontSize: (screenWidth * 0.015).clamp(12.0, 18.0),
                    color: isDarkMode ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
