import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final double width;
  final String imageUrl;
  final bool imageFirst;
  final String githubUrl;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.width,
    required this.imageUrl,
    required this.imageFirst,
    required this.githubUrl,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = (width * 0.018).clamp(18.0, 32.0);
    final double descFontSize = (width * 0.012).clamp(14.0, 22.0);

    // **Proportional Padding: Scales with Screen Width**
    final double verticalPadding = (width * 0.015).clamp(10, 25); // Between 10px and 25px
    final double horizontalPadding = (width * 0.03).clamp(15, 40); // Between 15px and 40px

    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageFirst
            ? [
          if (width >= 850) ProjectImage(imageUrl: imageUrl),
          if (width >= 850) const SizedBox(width: 20),
          Flexible(
            child: ProjectDetails(
              title: title,
              description: description,
              titleFontSize: titleFontSize,
              descFontSize: descFontSize,
              githubUrl: githubUrl,
            ),
          ),
        ]
            : [
          Flexible(
            child: ProjectDetails(
              title: title,
              description: description,
              titleFontSize: titleFontSize,
              descFontSize: descFontSize,
              githubUrl: githubUrl,
            ),
          ),
          if (width >= 850) const SizedBox(width: 20),
          if (width >= 850) ProjectImage(imageUrl: imageUrl),
        ],
      ),
    );
  }
}

class ProjectDetails extends StatefulWidget {
  final String title;
  final String description;
  final double titleFontSize;
  final double descFontSize;
  final String githubUrl;

  const ProjectDetails({
    super.key,
    required this.title,
    required this.description,
    required this.titleFontSize,
    required this.descFontSize,
    required this.githubUrl,
  });

  @override
  _ProjectDetailsState createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = screenWidth > 850
        ? (screenWidth * 0.85).clamp(600, 850)
        : (screenWidth * 0.85).clamp(300, 550);
    final double baseFontSize = screenWidth > 850 ? 15 : 13;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDarkMode ? Colors.white : Colors.black,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xFF252526) : const Color(0xFFE0E0E0),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    "${widget.title}.dart",
                    style: GoogleFonts.spaceMono(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: baseFontSize,
                    ),
                  ),
                  const Spacer(),
                   Icon(Icons.remove, size: 16,                      color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                   Icon(Icons.crop_square, size: 16,                       color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(width: 8),
                   Icon(Icons.close, size: 16,                       color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ),

            // Description
            Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(
                  children: _getFormattedText(widget.description, isDarkMode, baseFontSize),
                  style: GoogleFonts.spaceMono(
                    color: isDarkMode ? Colors.white : Colors.black,
                    fontSize: baseFontSize,
                  ),
                ),
              ),
            ),

            // GitHub Link
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: MouseRegion(
                onEnter: (_) => setState(() => isHovering = true),
                onExit: (_) => setState(() => isHovering = false),
                child: GestureDetector(
                  onTap: () async {
                    final Uri url = Uri.parse(widget.githubUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    }
                  },
                  child: Text(
                    "Check it out on GitHub --- Tap",
                    style: GoogleFonts.spaceMono(
                      color: isHovering ? Colors.blue : (isDarkMode ? Colors.white : Colors.black),
                      fontSize: baseFontSize,
                      decoration: isHovering ? TextDecoration.underline : TextDecoration.none,
                    ),
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

List<TextSpan> _getFormattedText(String text, bool isDarkMode, double fontSize) {
  final RegExp exp = RegExp(r'\*\*(.*?)\*\*');
  List<TextSpan> spans = [];
  int lastIndex = 0;

  for (final Match match in exp.allMatches(text)) {
    if (match.start > lastIndex) {
      spans.add(TextSpan(text: text.substring(lastIndex, match.start)));
    }

    spans.add(
      TextSpan(
        text: match.group(1),
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
            fontSize: fontSize),
      ),
    );
    lastIndex = match.end;
  }

  if (lastIndex < text.length) {
    spans.add(TextSpan(text: text.substring(lastIndex)));
  }

  return spans;
}


class ProjectImage extends StatelessWidget {
  final String imageUrl;

  const ProjectImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Adjust width and height dynamically
    double imageWidth = screenWidth * 0.3; // Reduce width
    double imageHeight = screenHeight * 0.7; // Increase height slightly

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.asset(
        imageUrl,
        width: imageWidth.clamp(200, 350), // Min 200px, Max 400px
        height: imageHeight.clamp(400, 550), // Min 350px, Max 600px
        fit: BoxFit.contain,
      ),
    );
  }
}


