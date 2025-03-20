import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:port_folio/theme/theme.dart';

class AppCard extends StatefulWidget {
  final List<String> mockupImages;
  final Function(int) onIndexChanged;

  const AppCard({
    super.key,
    required this.mockupImages,
    required this.onIndexChanged,
  });

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final bool isSmallScreen = screenWidth < 850;

    final double containerWidth = screenWidth * (isSmallScreen ? 0.35 : 0.26);
    final double containerHeight = isSmallScreen
        ? (screenHeight * 0.12).clamp(30.0, 110.0)
        : (screenHeight * 0.75).clamp(200.0, 600.0);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: containerWidth + (isSmallScreen ? 80 : 120),
            height: isSmallScreen ? null : containerHeight + 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CarouselSlider.builder(
                  carouselController: _carouselController,
                  itemCount: widget.mockupImages.length,
                  itemBuilder: (context, index, realIndex) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _currentIndex = index;
                        });
                        widget.onIndexChanged(index);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          widget.mockupImages[index],
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
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                      widget.onIndexChanged(index);
                    },
                  ),
                ),

                // Left Arrow (Always Visible)
                Positioned(
                  left: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: isDarkTheme ? darkTextColor : lightTextColor,
                    ),
                    onPressed: () {
                      _carouselController.previousPage();
                    },
                  ),
                ),

                // Right Arrow (Always Visible)
                Positioned(
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 24,
                      color: isDarkTheme ? darkTextColor : lightTextColor,
                    ),
                    onPressed: () {
                      _carouselController.nextPage();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
