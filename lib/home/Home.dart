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


    return SizedBox(
      height: bodyHeight,
      width: screenWidth,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isLargeScreen) {
            return Row(
              children: [
                Flexible(
                    child: AvatarWidget(
                        screenWidth: screenWidth,
                        isDarkMode: isDarkMode,
                        isLargeScreen: isLargeScreen)),
                Flexible(
                  child: Column(
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
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarWidget(
                    screenWidth: screenWidth,
                    isDarkMode: isDarkMode,
                    isLargeScreen: isLargeScreen),
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
