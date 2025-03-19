import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

class AppCard extends StatefulWidget {
  final List<String> mockupImages; // List of image paths
  const AppCard({super.key, required this.mockupImages});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController(); // Fixed controller

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double containerWidth = screenWidth * 0.3; // Adjust container size
    final double containerHeight = screenHeight * 0.75;

    // Adaptive background color based on theme
    final ThemeData theme = Theme.of(context);
    bool isDarkMode =   theme.brightness == Brightness.dark;
    final Color backgroundColor =
   isDarkMode ? Colors.grey[900]! : Colors.grey[200]!;

    return Center(
      child: SizedBox(
        width: containerWidth + 20,
        height: containerHeight + 20,

        child: Stack(
          alignment: Alignment.center,
          children: [
            CarouselSlider.builder(
              carouselController: _carouselController,
              itemCount: widget.mockupImages.length,
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    _carouselController.animateToPage(index);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      widget.mockupImages[index],
                      width: containerWidth,
                      height: containerHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                height: containerHeight,

                enableInfiniteScroll: true,
                enlargeCenterPage: true,
                autoPlay: false,
                enlargeFactor: 0.3, // Controls how much the center image enlarges
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            // Left Button (closer to active image)
            Positioned(
              left: containerWidth * 0.1, // Moves inside near the active image
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 24),
                onPressed: () {
                  _carouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            // Right Button (closer to active image)
            Positioned(
              right: containerWidth * 0.1, // Moves inside near the active image
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 24),
                onPressed: () {
                  _carouselController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
