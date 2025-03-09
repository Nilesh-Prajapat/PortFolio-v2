import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';
import 'widgets/avatar.dart';
import 'widgets/introduction.dart';

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

    return Container(
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
                  child: IntroWidget(
                      screenWidth: screenWidth,
                      isLargeScreen: isLargeScreen,
                      isDarkMode: isDarkMode),
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
                    isDarkMode: isDarkMode),
              ],
            );
          }
        },
      ),
    );
  }
}
