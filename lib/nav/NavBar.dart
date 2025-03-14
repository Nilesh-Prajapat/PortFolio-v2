import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:port_folio/Project.dart';
import 'package:port_folio/home/Home.dart';
import 'package:port_folio/expertise/expertise.dart';
import 'package:port_folio/theme/theme.dart';
import 'dart:math';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<String> navItems = ['Home', 'Expertise', 'Projects', 'Contact Me'];
  bool showDropdown = false;
  int selectedIndex = 0;
  final ScrollController _scrollController = ScrollController();

  // Global Keys for Sections
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _expertiseKey = GlobalKey();
  final GlobalKey _projectKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // Detect explicit user scroll
  void _handleScroll() {
    int newIndex = _getClosestSectionIndex();
    if (newIndex != selectedIndex) {
      setState(() {
        selectedIndex = newIndex;
      });
    }
  }

  // Find the section closest to the top of the screen
  int _getClosestSectionIndex() {
    List<GlobalKey> keys = [_homeKey, _expertiseKey, _projectKey, _contactKey];

    double minDistance = double.infinity;
    int closestIndex = selectedIndex; // Default to current section

    for (int i = 0; i < keys.length; i++) {
      final RenderBox? box =
          keys[i].currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        double offset = box.localToGlobal(Offset.zero).dy;
        double distance = (offset - kToolbarHeight).abs();
        if (distance < minDistance) {
          minDistance = distance;
          closestIndex = i;
        }
      }
    }
    return closestIndex;
  }

  // Function to scroll to the selected section
  void _scrollToSection(GlobalKey sectionKey) {
    Scrollable.ensureVisible(
      sectionKey.currentContext!,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = MediaQuery.of(context).size.width < 850;
    Size size = MediaQuery.of(context).size;

    double headingFontSize = isMobile
        ? max(14, min(size.width * 0.045, 24))
        : max(16, min(size.width * 0.02, 28));

    double navItemFontSize = isMobile
        ? max(12, min(size.width * 0.035, 18))
        : max(13, min(size.width * 0.013, 18));

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                AppBar(
                  title: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.009),
                    child: Row(
                      children: [
                        Text(
                          './Nilesh ',
                          style: GoogleFonts.spaceMono(
                            fontSize: headingFontSize,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w500,
                            color: isDarkMode ? darkTextColor : lightTextColor,
                          ),
                        ),
                        Text(
                          'Prajapat',
                          style: GoogleFonts.spaceMono(
                            fontSize: headingFontSize,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w700,
                            color:
                                isDarkMode ? primaryColor : primaryColorLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  actions: isMobile
                      ? [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.009),
                            child: _buildMobileMenuButton(isDarkMode),
                          ),
                        ]
                      : [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.009),
                            child: Row(
                              children: [
                                ..._buildNavItems(navItemFontSize, isDarkMode),
                                _buildThemeToggleButton(isMobile),
                              ],
                            ),
                          ),
                        ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: [
                        Container(
                            key: _homeKey,
                            child:
                                const MainBody(appBarHeight: kToolbarHeight)),
                        Container(
                          key: _expertiseKey,
                          child: SkillsPage(appBarHeight: kToolbarHeight),
                        ),
                        // Container(
                        //     key: _projectKey,
                        //     child:  ProjectsSection(
                        //         )
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (isMobile && showDropdown)
              Positioned(
                top: kToolbarHeight,
                left: 0,
                right: 0,
                child: Container(
                  width: size.width,
                  color: isDarkMode ? darkBackground : lightBackground,
                  child: Column(
                    children: [
                      ...navItems.asMap().entries.map((entry) {
                        int index = entry.key;
                        String item = entry.value;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.02, vertical: 4),
                          child: TextButton(
                            style: ButtonStyle(
                                overlayColor:
                                    WidgetStateProperty.all(Colors.transparent),
                                splashFactory: NoSplash.splashFactory),
                            onPressed: () {
                              setState(() {
                                showDropdown = false;
                                selectedIndex = index;
                              });
                              _scrollToSection(_getSectionKey(index));
                            },
                            child: Text(
                              item,
                              style: GoogleFonts.spaceMono(
                                color: selectedIndex == index
                                    ? isDarkMode
                                        ? primaryColor
                                        : primaryColorLight
                                    : isDarkMode
                                        ? darkTextColor
                                        : lightTextColor,
                                letterSpacing: 2.0,
                                fontSize: navItemFontSize * 1.1,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      const Divider(),
                      Center(child: _buildThemeToggleButton(isMobile)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  GlobalKey _getSectionKey(int index) {
    switch (index) {
      case 0:
        return _homeKey;
      case 1:
        return _expertiseKey;
      case 2:
        return _projectKey;
      case 3:
        return _contactKey;
      default:
        return _homeKey;
    }
  }

  List<Widget> _buildNavItems(double textSize, bool isDarkMode) {
    return navItems.asMap().entries.map((entry) {
      int index = entry.key;
      String item = entry.value;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextButton(
          style: const ButtonStyle(
              // splashFactory: NoSplash.splashFactory,
              // overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
          onPressed: () {
            setState(() {
              selectedIndex = index;
            });
            _scrollToSection(_getSectionKey(index));
          },
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            style: GoogleFonts.spaceMono(
              color: selectedIndex == index
                  ? isDarkMode
                      ? primaryColor
                      : primaryColorLight
                  : (isDarkMode ? darkTextColor : lightTextColor),
              letterSpacing: 2.0,
              fontSize: textSize,
            ),
            child: Text(item),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildMobileMenuButton(bool isDarkMode) {
    return IconButton(
      icon: ImageIcon(
        AssetImage(
            showDropdown ? "assets/icon/close.png" : "assets/icon/menu.png"),
        color: isDarkMode ? Colors.white : Colors.black,
        // Use correct asset paths
      ),
      onPressed: () {
        setState(() {
          showDropdown = !showDropdown;
        });
      },
    );
  }

  Widget _buildThemeToggleButton(bool isMobile) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        bool isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) => RotationTransition(
              turns: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: IconButton(
              key: ValueKey<bool>(isDark),
              icon: Icon(
                isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                color: isDark ? primaryColor : primaryColorLight,
                size: 28,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
                // if (isMobile) {
                //   showDropdown = !showDropdown;
                // }
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildExpertisePage(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
      child: const Center(child: Text('Expertise Page')),
    );
  }

  Widget _buildProjectPage(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
      child: const Center(child: Text('Project Page')),
    );
  }

  Widget _buildContactPage(double screenWidth, double screenHeight) {
    return SizedBox(
      width: screenWidth * 0.8,
      height: screenHeight * 0.8,
      child: const Center(child: Text('Contact Me Page')),
    );
  }
}
