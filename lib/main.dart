import 'package:flutter/material.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(16.0),
      darkTheme: darkTheme(16.0),
      themeMode: themeProvider.themeMode,
      home: const SplashScreen(), // Directly showing the SplashScreen
    );
  }
}
