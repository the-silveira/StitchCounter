import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stitchcounter/models/project.dart';

class StorageService {
  static const String _projectsKey = 'projects';
  static const String _currentProjectKey = 'currentProjectId';
  
  static Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();
  
  // Save projects list
  static Future<void> saveProjects(List<Project> projects) async {
    final prefs = await _prefs;
    final projectsJson = projects.map((p) => jsonEncode(p.toMap())).toList();
    await prefs.setStringList(_projectsKey, projectsJson);
  }
  
  // Load projects list
  static Future<List<Project>> loadProjects() async {
    final prefs = await _prefs;
    final projectsJson = prefs.getStringList(_projectsKey);
    if (projectsJson == null) return [];
    
    return projectsJson
        .map((json) => Project.fromMap(jsonDecode(json)))
        .toList();
  }
  
  // Save current project ID
  static Future<void> saveCurrentProjectId(String projectId) async {
    final prefs = await _prefs;
    await prefs.setString(_currentProjectKey, projectId);
  }
  
  // Load current project ID
  static Future<String?> loadCurrentProjectId() async {
    final prefs = await _prefs;
    return prefs.getString(_currentProjectKey);
  }
  
  // Add a new project
  static Future<void> addProject(Project project) async {
    final projects = await loadProjects();
    projects.add(project);
    await saveProjects(projects);
  }
  
  // Update a project
  static Future<void> updateProject(Project updatedProject) async {
    final projects = await loadProjects();
    final index = projects.indexWhere((p) => p.id == updatedProject.id);
    if (index != -1) {
      projects[index] = updatedProject;
      await saveProjects(projects);
    }
  }
  
  // Delete a project
  static Future<void> deleteProject(String projectId) async {
    final projects = await loadProjects();
    projects.removeWhere((p) => p.id == projectId);
    await saveProjects(projects);
  }
}