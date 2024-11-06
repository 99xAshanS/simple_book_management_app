import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(CombinedApp());

class CombinedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(), // Ensure HomePage is correctly imported and used here
    );
  }
}
