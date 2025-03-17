import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';
import 'package:port_folio/utils/popup.dart';

import '../utils/LayoutConstraints.dart';

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
    final size = Utils.size(context);
   final double containerWidth = (size.width * 0.85).clamp(300, 850);
    final containerHeight = size.height * 0.5;

   final xPos = (size.width - containerWidth) / 2;
    final yPos = (size.height ) / 3;
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          barrierDismissible: false, // Prevents background interaction
          builder: (context) {
            return Popup( discription: widget.description, icon:widget.icon, title: widget.name, containerWidth: containerWidth, xPos: xPos, yPos: yPos,lock:(1.5),popupType: 'skill',);
          },
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
