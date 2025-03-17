import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/theme.dart';
import '../utils/textParse.dart';
import 'LayoutConstraints.dart';

class Popup extends StatefulWidget {
  final String discription;
  final dynamic icon; // IconData or Image Path (String)
  final String title;
  final String popupType;
  final double containerWidth;
  final double xPos;
  final double yPos;
  final double lock;

  const Popup({
    super.key,
    required this.discription,
    required this.icon,
    required this.title,
    required this.popupType,
    required this.containerWidth,
    required this.xPos,
    required this.yPos,
    required this.lock,
  });

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  late ValueNotifier<double> xPos;
  late ValueNotifier<double> yPos;
  late double lock;
  late double containerWidth;
  late double containerHeight;
  late Size screenSize;

  @override
  void initState() {
    super.initState();
    xPos = ValueNotifier(widget.xPos);
    yPos = ValueNotifier(widget.yPos);
    lock = widget.lock;
    containerWidth = widget.containerWidth;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
    _setPopupConstraints();
  }

  void _setPopupConstraints() {
    switch (widget.popupType) {
      case "aboutMe":
        containerWidth = Utils.containerWidth(context);
        xPos.value = (screenSize.width - containerWidth) / 2;
        yPos.value = (screenSize.height / 10);
        lock = 2;
        break;

      case "submit":
        containerWidth = 320;
        containerHeight = 150;
        xPos.value = (screenSize.width / 2 - 160);
        yPos.value = (screenSize.height / 3);
        lock = 1.18;
        break;

      case "skill":
        containerWidth = (screenSize.width * 0.85).clamp(300, 850);
        containerHeight = screenSize.height * 0.5;
        xPos.value = (screenSize.width - containerWidth) / 2;
        yPos.value = (screenSize.height) / 3;
        lock = 1.5;
        break;

      default:
        containerWidth = screenSize.width * 0.4;
        containerHeight = screenSize.height * 0.4;
        xPos.value = (screenSize.width - containerWidth) / 2;
        yPos.value = (screenSize.height - containerHeight) / 2;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Utils.isDarkMode(context);
    final double baseFontSize = screenSize.width > 850 ? 15 : 13;
    final double iconSize = screenSize.width > 850 ? 22 : 16;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () =>
            Navigator.of(context).pop(), // Close popup when tapping outside
        behavior: HitTestBehavior.opaque, // Detects taps on empty areas
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(color: Colors.black.withOpacity(0.3)),
              ),
            ),
            ValueListenableBuilder<double>(
              valueListenable: xPos,
              builder: (_, x, __) => ValueListenableBuilder<double>(
                valueListenable: yPos,
                builder: (_, y, __) => Positioned(
                  left: x,
                  top: y,
                  child: RepaintBoundary(
                    child: GestureDetector(
                      onTap: () {},
                      onPanUpdate: (details) {
                        xPos.value = (xPos.value + details.delta.dx)
                            .clamp(0, screenSize.width - containerWidth);
                        yPos.value = (yPos.value + details.delta.dy)
                            .clamp(0, screenSize.height / lock);
                      },
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          width: containerWidth,
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color(0xFF1E1E1E)
                                : const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _PopupHeader(
                                title: "${widget.title}.dart",
                                icon: widget.icon,
                                iconSize: iconSize,
                                isDarkMode: isDarkMode,
                                onCopy: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.discription));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Copied to clipboard!",
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? darkTextColor
                                              : lightTextColor,
                                        ),
                                      ),
                                      backgroundColor: isDarkMode
                                          ? Colors.grey[900]
                                          : Colors.grey[300],
                                    ),
                                  );
                                },
                                onClose: () => Navigator.of(context).pop(),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: RichText(
                                  text: TextSpan(
                                    children: getFormattedText(
                                        widget.discription,
                                        isDarkMode: isDarkMode,
                                        fontSize: baseFontSize),
                                    style: GoogleFonts.spaceMono(
                                      color: isDarkMode
                                          ? darkTextColor
                                          : lightTextColor,
                                      fontSize: baseFontSize,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PopupHeader extends StatelessWidget {
  final String title;
  final dynamic icon;
  final double iconSize;
  final bool isDarkMode;
  final VoidCallback onCopy;
  final VoidCallback onClose;

  const _PopupHeader({
    required this.title,
    required this.icon,
    required this.iconSize,
    required this.isDarkMode,
    required this.onCopy,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDarkMode ? const Color(0xFF252526) : const Color(0xFFE0E0E0),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          if (icon is IconData)
            Icon(icon,
                color: isDarkMode ? darkTextColor : lightTextColor,
                size: iconSize)
          else if (icon is String)
            Image.asset(icon, width: iconSize, height: iconSize),
          const SizedBox(width: 5),
          Text(title, style: GoogleFonts.spaceMono(fontSize: 14)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.copy), onPressed: onCopy),
          IconButton(icon: const Icon(Icons.close), onPressed: onClose),
        ],
      ),
    );
  }
}
