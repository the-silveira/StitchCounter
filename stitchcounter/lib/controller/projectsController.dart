import 'package:flutter/material.dart';
import 'package:stitchcounter/models/project.dart';
import 'package:stitchcounter/services/storageService.dart';
import 'package:stitchcounter/ui/counterUI.dart';
import 'package:stitchcounter/widgets/editProjectCard.dart';
import 'package:stitchcounter/widgets/newProjectDialog.dart';
import 'package:stitchcounter/widgets/projectOptionsBottomSheet.dart';
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

    final newProject = Project(id: const Uuid().v4(), name: name.trim());

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
      orElse: () =>
          _projects.isNotEmpty ? _projects.first : _createDefaultProject(),
    );
  }

  Future<void> navigateToProject(BuildContext context, Project project) async {
    await setCurrentProject(project.id);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(project: project)),
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

  Future<bool> showDeleteProjectDialog(
    BuildContext context,
    Project project,
  ) async {
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
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Project _createDefaultProject() {
    return Project(id: const Uuid().v4(), name: 'My First Project');
  }

  Future<void> updateProject(String projectId, String newName) async {
    if (newName.trim().isEmpty) return;

    try {
      final index = _projects.indexWhere((p) => p.id == projectId);
      if (index != -1) {
        _projects[index].name = newName.trim();
        await StorageService.saveProjects(_projects);
        notifyListeners();
      }
    } catch (e) {
      print('Error updating project: $e');
      await loadProjects();
    }
  }

  void showProjectOptions(Project project, BuildContext context) {
    showProjectOptionsBottomSheet(
      context: context,
      onEdit: () => showEditDialog(project, context),
      onDelete: () async {
        final confirmed = await showDeleteProjectDialog(context, project);
        if (confirmed == true) {
          await deleteProject(project.id);
        }
      },
    );
  }

  void showEditDialog(Project project, BuildContext context) {
    showEditProjectDialog(
      context: context,
      currentName: project.name,
      onSave: (newName) {
        updateProject(project.id, newName);
      },
    );
  }

  void showNewProjectDialog(BuildContext context) {
    newProjectDialog(
      context: context,
      onCreate: (name) {
        addProject(name);
      },
    );
  }
}
