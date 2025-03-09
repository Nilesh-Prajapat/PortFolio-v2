import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

class AvatarWidget extends StatelessWidget {
  final double screenWidth;
  final bool isDarkMode;
  final bool isLargeScreen;

  const AvatarWidget({
    super.key,
    required this.screenWidth,
    required this.isDarkMode,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    double avatarSize = (isLargeScreen ? screenWidth * 0.15 : screenWidth * 0.32)
        .clamp(80.0, 180.0);

    return Center(
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isDarkMode ? primaryColor : primaryColorLight,
              spreadRadius: 10,
              blurRadius: 50,
            ),
          ],
        ),
        child: CircleAvatar(
          radius: avatarSize,
          backgroundImage: const AssetImage('assets/images/profile.jpg'),
        ),
      ),
    );
  }
}
