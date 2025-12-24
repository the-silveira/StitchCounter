// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stitchcounter/services/theme.dart';
import 'package:stitchcounter/ui/counterUI.dart';

void main() {
  // Lock to landscape mode
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(const CrochetHelperApp());
}

class CrochetHelperApp extends StatelessWidget {
  const CrochetHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crochet Helper',
      theme: AppTheme.lightTheme,
      home: const CounterUI(),
      debugShowCheckedModeBanner: false,
    );
  }
}
