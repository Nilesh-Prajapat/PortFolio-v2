import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    _loadAssets();
  }

  Future<void> _loadAssets() async {
    try {
      final manifestJson = await rootBundle.loadString('AssetManifest.json');
      final Map<String, dynamic> manifest = await compute(parseJson, manifestJson);

      final imagePaths = manifest.keys.where((key) =>
      key.endsWith('.png') || key.endsWith('.jpg') || key.endsWith('.webp')).toList();

      if (mounted) {
        for (final path in imagePaths) {
          precacheImage(AssetImage(path), context);
        }
      }
    } catch (e) {
      debugPrint("Error preloading images: $e");
    }
  }

  static Map<String, dynamic> parseJson(String jsonString) {
    return jsonDecode(jsonString);
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
