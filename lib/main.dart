import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:port_folio/utils/splashscreen.dart';
import 'package:port_folio/theme/theme_provider.dart';

import 'theme/theme.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),

    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadProfileImage();

  }

  void _preloadProfileImage() {
    const String profileImagePath = 'assets/images/profile.webp';
    precacheImage(const AssetImage(profileImagePath), context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Nilesh Prajapat | App Developer & Student | Portfolio',
          debugShowCheckedModeBanner: false,
          theme: lightTheme(16.0),
          darkTheme: darkTheme(16.0),
          themeMode: themeProvider.themeMode,
          home: const SplashScreen(),
        );
      },
    );
  }
}
