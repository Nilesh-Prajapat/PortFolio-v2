import 'package:flutter/material.dart';
import 'avatar.dart';
import 'introduction.dart';

class MainBody extends StatefulWidget {
  final double appBarHeight;

  const MainBody({super.key, required this.appBarHeight});

  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLargeScreen = screenWidth > 850;
    double bodyHeight = screenHeight - widget.appBarHeight;

    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: bodyHeight, // Minimum height of the body
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isLargeScreen) {
            return IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: AvatarWidget(
                      screenWidth: screenWidth,
                      isDarkMode: isDarkMode,
                      isLargeScreen: isLargeScreen,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntroWidget(
                          screenWidth: screenWidth,
                          isLargeScreen: isLargeScreen,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min, // Allows dynamic expansion
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarWidget(
                  screenWidth: screenWidth,
                  isDarkMode: isDarkMode,
                  isLargeScreen: isLargeScreen,
                ),
                const SizedBox(height: 80),
                IntroWidget(
                  screenWidth: screenWidth,
                  isLargeScreen: isLargeScreen,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
