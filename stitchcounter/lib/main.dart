import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stitchcounter/controller/projectsController.dart';
import 'package:stitchcounter/services/theme.dart';
import 'package:stitchcounter/ui/counterUI.dart';
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
  late Future<Widget> _initialScreen;

  Future<Widget> _determineInitialScreen() async {
    final controller = ProjectsController();
    await controller.loadProjects();
    
    final currentProject = await controller.getCurrentProject();
    
    if (currentProject != null) {
      return MainScreen(project: currentProject);
    } else {
      return const ProjectsScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    _initialScreen = _determineInitialScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _initialScreen,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return const Scaffold(
              body: Center(
                child: Text('Error loading app'),
              ),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}