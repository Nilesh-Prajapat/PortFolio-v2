import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:port_folio/splashscreen.dart';
import 'package:provider/provider.dart';
import 'package:port_folio/theme_provider.dart';

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
  late Future<void> _assetsFuture;

  @override
  void initState() {
    super.initState();
    _assetsFuture = _loadAssets();
  }

  // Load images and fonts from assets
  Future<void> _loadAssets() async {
    await _preloadImages('assets/images');
    await _preloadImages('assets/icons');
    await _loadFonts();
  }

  // Preload images
  Future<void> _preloadImages(String directory) async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = jsonDecode(manifestJson);

    final imageFiles = manifest.keys
        .where((String key) => key.startsWith(directory) && (key.endsWith('.png') || key.endsWith('.jpg')))
        .toList();

    for (final file in imageFiles) {
      precacheImage(AssetImage(file), context);
    }
  }

  // Preload fonts
  Future<void> _loadFonts() async {
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = jsonDecode(manifestJson);

    final fontFiles = manifest.keys
        .where((String key) => key.startsWith('assets/fonts') && key.endsWith('.ttf'))
        .toList();

    for (final font in fontFiles) {
      await rootBundle.load(font);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(16.0),
      darkTheme: darkTheme(16.0),
      themeMode: themeProvider.themeMode,
      home:  SplashScreen(),
    );
  }
}
