import 'package:flutter/material.dart';
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
  late AnimationController _controller;
  late Animation<double> _animation;

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double avatarSize = widget.isLargeScreen
        ? (widget.screenWidth * 0.20).clamp(120.0, 220.0) // Slightly reduced max size
        : (widget.screenWidth * 0.32).clamp(80.0, 180.0);

    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: child,
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
            radius: avatarSize,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
          ),
        ),
      ),
    );
  }
}
