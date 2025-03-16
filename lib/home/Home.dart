import 'package:flutter/material.dart';
import 'package:port_folio/utils/LayoutConstraints.dart';
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
    bool isDarkMode = Utils.isDarkMode(context);
    final Size size = Utils.size(context);
    final isLargeScreen = size.width > 850;
    double bodyHeight = size.height - widget.appBarHeight;

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
                      screenWidth: size.width,
                      isDarkMode: isDarkMode,
                      isLargeScreen: isLargeScreen,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Prevents unnecessary expansion
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntroWidget(),
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
                  screenWidth: size.width,
                  isDarkMode: isDarkMode,
                  isLargeScreen: isLargeScreen,
                ),
                const SizedBox(height: 80),
                IntroWidget(),
              ],
            );
          }
        },
      ),
    );
  }
}
