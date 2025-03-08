import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:port_folio/theme_provider.dart';
import 'package:port_folio/NavBar.dart';
import 'package:port_folio/theme/theme.dart';

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
    bool isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: isDarkMode ? Colors.black : Color(0xFFF2F2F2),
        statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
        systemNavigationBarColor:  isDarkMode ? Colors.black : Color(0xFFF2F2F2),

      ),
    );

    return FutureBuilder(
      future: themeProvider.themeLoaded,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme(16.0, false), // Light Theme
          darkTheme: appTheme(16.0, true), // Dark Theme
          themeMode: themeProvider.themeMode,
          home: const Navbar(),
        );
      },
    );
  }
}
