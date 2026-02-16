import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stitchcounter/services/theme.dart';
import 'package:stitchcounter/ui/projectsUI.dart';

void main() async {
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
      home: const AppLoader(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({super.key});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProjectsScreen();
  }
}
