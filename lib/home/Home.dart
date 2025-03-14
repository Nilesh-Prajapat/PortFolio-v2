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
  late double screenWidth;
  late bool isLargeScreen;
  late double bodyHeight;

  @override
  void initState() {
    super.initState();
    final mediaQuery = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first);
    screenWidth = mediaQuery.size.width;
    isLargeScreen = screenWidth > 850;
    bodyHeight = mediaQuery.size.height - widget.appBarHeight;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark; // Ensure theme updates dynamically

    return SizedBox(
      height: bodyHeight,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (isLargeScreen) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: AvatarWidget(isDarkMode: isDarkMode,
                    screenWidth: screenWidth,
                    isLargeScreen: isLargeScreen,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: IntroWidget(
                      screenWidth: screenWidth,
                      isLargeScreen: isLargeScreen,
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AvatarWidget(isDarkMode: isDarkMode,
                  screenWidth: screenWidth,
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
