import 'package:flutter/material.dart';
import 'package:port_folio/utils/LayoutConstraints.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:port_folio/theme/theme.dart';

class AvatarWidget extends StatefulWidget {
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
  _AvatarWidgetState createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  bool isVisible = true;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: -4, end: 4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    isAnimating = true;
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    bool shouldBeVisible = info.visibleFraction > 0;
    if (shouldBeVisible != isVisible) {
      isVisible = shouldBeVisible;
      if (isVisible && !isAnimating) {
        _controller.repeat(reverse: true);
        isAnimating = true;
      } else if (!isVisible && isAnimating) {
        _controller.stop();
        isAnimating = false;
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return VisibilityDetector(
      key: const Key('avatar-widget'),
      onVisibilityChanged: _onVisibilityChanged,
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: child!,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: widget.isDarkMode ? primaryColor : primaryColorLight,
                  spreadRadius: 8,
                  blurRadius: 50,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: Utils.avatarSize(context),
              backgroundColor: Colors.transparent, // Fixes blue overlay issue
              backgroundImage: const AssetImage('assets/images/profile.webp'),
            ),
          ),
        ),
      ),
    );
  }
}
