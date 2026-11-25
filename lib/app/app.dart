import 'package:flutter/material.dart';
import '../features/navigation/views/main_screen.dart';
import 'theme/app_theme.dart';

class AtmosApp extends StatelessWidget {
  const AtmosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Atmos',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainScreen(),
    );
  }
}
