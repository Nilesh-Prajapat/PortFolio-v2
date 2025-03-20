import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class AppCard extends StatefulWidget {
  final List<String> mockupImages; // List of image paths
  const AppCard({super.key, required this.mockupImages});

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController(); // ✅ Fixed controller

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    final double containerWidth = screenWidth * 0.28; // Adjust container size
    final double containerHeight = screenHeight * 0.75;
    final double imageWidth = screenWidth * 0.3;
    final double imageHeight = screenHeight * 0.75;

    // Adjust button spacing dynamically based on screen width
    final double buttonSpacing = screenWidth * 0.02; // Slightly away from the image

    return Center(
      child: SizedBox(
        width: containerWidth +( buttonSpacing * 2 ) + 40, // Adjusted width
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
                      width: imageWidth,
                      height: imageHeight,
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
                viewportFraction: 1,
                enlargeFactor: 0.3, // Controls how much the center image enlarges
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            // Left Button (slightly away from the image)
            Positioned(
              left: buttonSpacing, // Moves slightly outward
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios, size: 28, color: Colors.white),
                onPressed: () {
                  _carouselController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            // Right Button (slightly away from the image)
            Positioned(
              right: buttonSpacing, // Moves slightly outward
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios, size: 28, color: Colors.white),
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
