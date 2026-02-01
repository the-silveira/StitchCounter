import 'package:flutter/material.dart';
import 'package:stitchcounter/models/project.dart';
import 'package:stitchcounter/services/storageService.dart';
import 'package:stitchcounter/ui/projectsUI.dart';


class CounterController {
  Project project;
  
  CounterController({required this.project});
  
  void incrementStitch() {
    project.stitch.increment();
    _saveProject();
  }
  
  void decreaseStitch() {
    project.stitch.decrease();
    _saveProject();
  }
  
  void resetStitch() {
    project.stitch.reset();
    _saveProject();
  }
  
  void incrementRound() {
    project.round.increment();
    project.stitch.reset();
    _saveProject();
  }
  
  void decreaseRound() {
    project.round.decrease();
    _saveProject();
  }
  
  void resetRound() {
    project.round.reset();
    _saveProject();
  }
  
  void resetAll() {
    project.stitch.reset();
    project.round.reset();
    _saveProject();
  }
  
  Future<void> _saveProject() async {
    await StorageService.updateProject(project);
  }

  void goToProjects(BuildContext context) {
   
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ProjectsScreen(),
      ),
    );
  
  }
}