import 'package:flutter/material.dart';
import 'package:stitchcounter/models/project.dart';
import 'package:stitchcounter/services/storageService.dart';
import 'package:stitchcounter/ui/counterUI.dart';
import 'package:uuid/uuid.dart';

class ProjectsController extends ChangeNotifier {
  List<Project> _projects = [];
  
  List<Project> get projects => _projects;
  
  Future<void> loadProjects() async {
    _projects = await StorageService.loadProjects();
    notifyListeners();
  }
  
  Future<void> addProject(String name) async {
    if (name.trim().isEmpty) return;
    
    final newProject = Project(
      id: const Uuid().v4(),
      name: name.trim(),
    );
    
    await StorageService.addProject(newProject);
    await loadProjects();
  }
  
  Future<void> deleteProject(String projectId) async {
    await StorageService.deleteProject(projectId);
    await loadProjects();
  }
  
  Future<void> setCurrentProject(String projectId) async {
    await StorageService.saveCurrentProjectId(projectId);
  }
  
  Future<Project?> getCurrentProject() async {
    final currentProjectId = await StorageService.loadCurrentProjectId();
    if (currentProjectId == null) return null;
    
    await loadProjects();
    return _projects.firstWhere(
      (p) => p.id == currentProjectId,
      orElse: () => _projects.isNotEmpty ? _projects.first : _createDefaultProject(),
    );
  }
  
  Future<void> navigateToProject(BuildContext context, Project project) async {
    await setCurrentProject(project.id);
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(project: project),
      ),
    );
  }
  
  Future<void> showAddProjectDialog(BuildContext context) async {
    final nameController = TextEditingController();
    
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Project'),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Project Name',
            hintText: 'Enter project name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              addProject(nameController.text);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
  
  Future<bool> showDeleteProjectDialog(BuildContext context, Project project) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Project'),
        content: Text('Are you sure you want to delete "${project.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
  
  Project _createDefaultProject() {
    return Project(
      id: const Uuid().v4(),
      name: 'My First Project',
    );
  }
}