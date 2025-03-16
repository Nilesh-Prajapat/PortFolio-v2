import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubmissionPopup extends StatefulWidget {
  final String message;

  const SubmissionPopup({super.key, required this.message});

  @override
  _SubmissionPopupState createState() => _SubmissionPopupState();
}

class _SubmissionPopupState extends State<SubmissionPopup>
    with SingleTickerProviderStateMixin {
  late double xPos;
  late double yPos;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;

      setState(() {
        xPos = (screenWidth - 320) / 2; // Centered horizontally
        yPos = screenHeight / 2; // Positioned at 1/3rd height
      });
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Stack(
        children: [
          Positioned(
            left: xPos,
            top: yPos,
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  xPos += details.delta.dx;
                  yPos += details.delta.dy;
                });
              },
              child: Container(
                width: 320,
                decoration: BoxDecoration(
                  color: isDarkMode
                      ? const Color(0xFF1E1E1E)
                      : const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color(0xFF252526)
                            : const Color(0xFFE0E0E0),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Colors.green, size: 24),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Submission Successful",
                              style: GoogleFonts.spaceMono(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close,
                                color:
                                    isDarkMode ? Colors.white : Colors.black),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.message,
                      style: GoogleFonts.spaceMono(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
