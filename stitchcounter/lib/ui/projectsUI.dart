// ui/projects_screen.dart
import 'package:flutter/material.dart';
import 'package:stitchcounter/controller/projectsController.dart';
import 'package:stitchcounter/helpers/colorsUI.dart';
import 'package:stitchcounter/widgets/projectCard.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  late final ProjectsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ProjectsController();
    _controller.addListener(_onProjectsUpdated);
    _loadProjects();
  }

  @override
  void dispose() {
    _controller.removeListener(_onProjectsUpdated);
    super.dispose();
  }

  void _onProjectsUpdated() {
    setState(() {
      // This will rebuild when controller notifies
    });
  }

  Future<void> _loadProjects() async {
    await _controller.loadProjects();
    // No need for setState here because listener will trigger
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('My Projects'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ColorHelperScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: _controller.projects.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: colorScheme.outline.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No projects yet',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first project',
                    style: TextStyle(
                      color: colorScheme.outline.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: _controller.projects.length,
              itemBuilder: (context, index) {
                final project = _controller.projects[index];
                return ProjectCard(
                  project: project,
                  onTap: () => _controller.navigateToProject(context, project),
                  onLongPress: () =>
                      _controller.showProjectOptions(project, context),
                  onConfirmDismiss: (_) async {
                    return await _controller.showDeleteProjectDialog(
                      context,
                      project,
                    );
                  },
                  onDismissed: (_) async {
                    await _controller.deleteProject(project.id);
                    // UI updates automatically via listener
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _controller.showNewProjectDialog(context),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: const Icon(Icons.add),
      ),
    );
  }
}
