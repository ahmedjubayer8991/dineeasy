import 'package:flutter/material.dart';
import 'routes.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const DineEasyApp());
}

class DineEasyApp extends StatelessWidget {
  const DineEasyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DineEasy',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
