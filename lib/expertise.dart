import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/skilsdata.dart';
import 'package:port_folio/widgets/skillsdetails.dart';

class SkillsPage extends StatelessWidget {
  final double appBarHeight;

  SkillsPage({required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Adjust cards per row dynamically
    int cardsPerRow = screenWidth > 900
        ? 5
        : screenWidth > 700
        ? 4
        : screenWidth > 500
        ? 3
        : 2;

    // Adjust card size dynamically
    double cardWidth = (screenWidth / (cardsPerRow + 0.3)) * 0.90;
    double cardHeight = cardWidth * 0.78;

    // Clamp card sizes for better responsiveness
    cardWidth = cardWidth.clamp(90, 150);
    cardHeight = cardHeight.clamp(80, 120);

    // Adjust spacing dynamically based on screen size
    double topSpacing = screenWidth > 850 ? 120 : (screenHeight * 0.05).clamp(30, 80);
    double bottomSpacing = screenWidth > 850 ? 120 : (screenHeight * 0.05).clamp(30, 80);

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: topSpacing), // Adjusted dynamic space above
              Text(
                "My Expertise",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: (screenWidth * 0.05).clamp(18, 28),
                  color: isDarkMode ? primaryColor : primaryColorLight,
                ),
              ),
              SizedBox(height: (screenHeight * 0.05).clamp(30, 80)), // Title spacing
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12, // Spacing between items
                runSpacing: 12,
                children: skills.map((skill) {
                  return SkillCard(
                    icon: skill["icon"]!,
                    name: skill["name"]!,
                    description: skill["description"]!, // Pass description here
                    height: cardHeight,
                    width: cardWidth,
                    isDarkMode: isDarkMode,
                  );
                }).toList(),
              ),
              SizedBox(height: bottomSpacing), // Adjusted dynamic space below
            ],
          ),
        ),
      ),
    );
  }
}


class SkillCard extends StatefulWidget {
  final String icon;
  final String name;
  final String description; // New field
  final double height;
  final double width;
  final bool isDarkMode;

  SkillCard({
    required this.icon,
    required this.name,
    required this.description, // Pass description
    required this.height,
    required this.width,
    required this.isDarkMode,
  });

  @override
  _SkillCardState createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (context, animation, secondaryAnimation) {
                return FadeTransition(
                  opacity: animation,
                  child: SkillDetailedPage(
                    skillName: widget.name,
                    skillIcon: widget.icon,
                    skillDescription: widget
                        .description, // Use passed description
                  ),
                );
              },
            ),
          );

        },


      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          width: (_isHovered ? widget.width * 1.11 : widget.width)
              .clamp(widget.width, widget.width * 1.11),
          height: (_isHovered ? widget.height * 1.11 : widget.height)
              .clamp(widget.height, widget.height * 1.11),
          decoration: BoxDecoration(
            border: Border.all(
              color: _isHovered
                  ? primaryColor
                  : (widget.isDarkMode ? Colors.white : Colors.black),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(widget.icon,
                  width: widget.width * 0.4, height: widget.height * 0.4),
              SizedBox(height: 10),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: (widget.width * 0.15).clamp(12, 16),
                  fontWeight: FontWeight.w500,
                  color: _isHovered
                      ? primaryColor
                      : (widget.isDarkMode ? Colors.white : Colors.black),
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
