import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

import 'skillsdetails.dart';

class SkillCard extends StatefulWidget {
  final String icon;
  final String name;
  final String description;
  final double height;
  final double width;
  final bool isDarkMode;

  SkillCard({
    required this.icon,
    required this.name,
    required this.description,
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
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: SkillDetailedPage(
                    skillName: widget.name,
                    skillIcon: widget.icon,
                    skillDescription: widget.description),
              );
            },
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Transform.scale(
          scale: _isHovered ? 1.1 : 1.0, // Scale effect on hover
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            decoration: BoxDecoration(
              border: Border.all(
                color: _isHovered
                    ? (widget.isDarkMode ? primaryColor : primaryColorLight)
                    : (widget.isDarkMode ? darkTextColor : lightTextColor),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Skill Icon
                Image.asset(
                  widget.icon,
                  width: widget.width * 0.4,
                  height: widget.height * 0.4,
                ),
                SizedBox(height: 10),

                // Skill Name
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: (widget.width * 0.15).clamp(12, 16),
                    fontWeight: FontWeight.w500,
                    color: _isHovered
                        ? (widget.isDarkMode ? primaryColor : primaryColorLight)
                        : (widget.isDarkMode ? darkTextColor : lightTextColor),
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
