import 'package:flutter/material.dart';
import 'package:whatif_project/config/routes/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => AppRoutes.onGenerate(settings),

    );
  }
}