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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
