import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tugtugan/config/app_config.dart';
import 'package:tugtugan/config/app_environments.dart';
import 'package:tugtugan/firebase/prod/firebase_options.dart';

void main() async {
  AppConfig.setEnvironment(Flavors.production);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "tugtugan",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Tugtugan Production!'),
        ),
      ),
    );
  }
}
