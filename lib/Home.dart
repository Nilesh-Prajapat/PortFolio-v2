import 'package:flutter/material.dart';
import 'NavBar.dart';

class MainBody extends StatelessWidget {
  final double appBarHeight;

  const MainBody({super.key, required this.appBarHeight});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final isLargeScreen = screenWidth > 800;

    // Conditionally calculate body height
    double bodyHeight = screenHeight - appBarHeight;


    return Container(
      child: Text("hellow"),
      height: bodyHeight,
      width: double.infinity,
    );
  }

  // Avatar with Shadow
  Widget _buildAvatarWithShadow(double width) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF1736),
            spreadRadius: 10,
            blurRadius: 50,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: width * 0.12,
        backgroundImage: const AssetImage('assets/images/profile.jpg'),
      ),
    );
  }

  // Introduction Section
  Widget _buildIntroductionSection(double screenWidth, bool isLargeScreen) {
    final baseFontSize = screenWidth * (isLargeScreen ? 0.015 : 0.040);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hello, I'm",
          style: TextStyle(
            fontFamily: 'Space',
            letterSpacing: 2,
            color: Colors.white,
            fontSize: baseFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "Nilesh Prajapat",
          style: TextStyle(
            fontFamily: 'Space',
            letterSpacing: 1,
            color: Colors.white,
            fontSize: baseFontSize * 1.4,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          textAlign: isLargeScreen ? TextAlign.start : TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "App Developer ",
                style: TextStyle(
                  fontFamily: 'Space',
                  color: const Color(0xFFFF1736),
                  letterSpacing: 1,
                  fontSize: baseFontSize * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "/ ",
                style: TextStyle(
                  fontFamily: 'Space',
                  color: const Color(0xFFFF1736),
                  fontSize: baseFontSize * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: "Student",
                style: TextStyle(
                  fontFamily: 'Space',
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: baseFontSize * 1.4,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "From",
              style: TextStyle(
                fontFamily: 'Space',
                letterSpacing: 2,
                color: Colors.white,
                fontSize: baseFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: ": ",
              style: TextStyle(
                fontFamily: 'Space',
                letterSpacing: 2,
                color: const Color(0xFFFF1736),
                fontSize: baseFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: "India",
              style: TextStyle(
                fontFamily: 'Space',
                letterSpacing: 2,
                color: Colors.white,
                fontSize: baseFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ),
        Container(
          child: isLargeScreen ? SizedBox.shrink() : const SizedBox(height: 20),
        ),
        Container(
          child: isLargeScreen
              ? SizedBox.shrink()
              : Row(
                  children: [
                    _buildButton(
                      "Resume",
                      screenWidth,
                      baseFontSize,
                      0xFFFF1736,
                      onPressed: () {},
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    _buildButton(
                      "Contact ME",
                      screenWidth,
                      baseFontSize,
                      0000000,
                    )
                  ],
                ),
        ),
        const SizedBox(height: 20),
        _buildSocialLinks(isLargeScreen, screenWidth),
      ],
    );
  }

  Widget _buildButton(
      String text, double screenWidth, double baseFontSize, int color,
      {Function? onPressed}) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(color), // Button color
        minimumSize:
            Size(screenWidth * 0.2, screenWidth * 0.1), // Width and height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: const Color(0xFFFF1736),
            width: 3, // Border width
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Space',
          fontSize: baseFontSize * 1.2,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Social Links Row
  Widget _buildSocialLinks(bool isLargeScreen, double screenWidth) {
    final iconSize = screenWidth * (isLargeScreen ? 0.025 : 0.078);
    final labelFontSize = screenWidth * (isLargeScreen ? 0.017 : 0.06);

    return isLargeScreen
        ? Column(
            children: [
              _socialIcon(
                  "assets/icon/github.png",
                  "Hellfire-Nilesh",
                  "https://github.com/HELLFIRE-NILESH",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
              const SizedBox(height: 20),
              _socialIcon(
                  "assets/icon/instagram.png",
                  "its.nilesh_pr",
                  "https://instagram.com/Its.nilesh.here",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
              const SizedBox(height: 20),
              _socialIcon(
                  "assets/icon/linked.png",
                  "Nilesh Prajapat",
                  "https://linkedin.com/in/NileshPrajapat",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
            ],
          )
        : Row(
            children: [
              _socialIcon(
                  "assets/icon/github.png",
                  "Hellfire-Nilesh",
                  "https://github.com/HELLFIRE-NILESH",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
              const SizedBox(width: 10),
              _socialIcon(
                  "assets/icon/instagram.png",
                  "its.nilesh_pr",
                  "https://instagram.com/Its.nilesh.here",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
              const SizedBox(width: 10),
              _socialIcon(
                  "assets/icon/linked.png",
                  "Nilesh Prajapat",
                  "https://linkedin.com/in/NileshPrajapat",
                  iconSize,
                  labelFontSize,
                  isLargeScreen),
            ],
          );
  }

  // Social Icon Widget
  Widget _socialIcon(String icon, String label, String url, double iconSize,
      double labelFontSize, bool isLargeScreen) {
    return GestureDetector(
      onTap: () {
        print("Navigating to $url");
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ImageIcon(
            AssetImage(icon),
            size: iconSize,
            color: const Color(0xFFFF1736),
          ),
          const SizedBox(width: 20),
          isLargeScreen
              ? Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Space',
                    color: Colors.white,
                    letterSpacing: 3,
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
