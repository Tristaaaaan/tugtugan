import 'package:flutter/material.dart';
import 'package:tugtugan/config/app_config.dart';
import 'package:tugtugan/config/app_environments.dart';

void main() {
  AppConfig.setEnvironment(Flavors.production);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Tugtugan Development!'),
        ),
      ),
    );
  }
}
