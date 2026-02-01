import 'package:flutter/material.dart';
import 'package:stitchcounter/controller/projectsController.dart';
import 'package:stitchcounter/helpers/colorsUI.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  final ProjectsController _controller = ProjectsController();
  
  @override
  void initState() {
    super.initState();
    _loadProjects();
  }
  
  Future<void> _loadProjects() async {
    await _controller.loadProjects();
    setState(() {});
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
                return Dismissible(
                  key: Key(project.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: colorScheme.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: colorScheme.onError),
                  ),
                  confirmDismiss: (_) async {
                    return await _controller.showDeleteProjectDialog(context, project);
                  },
                  onDismissed: (_) async {
                    await _controller.deleteProject(project.id);
                    setState(() {});
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    elevation: 2,
                    color: colorScheme.primary.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: colorScheme.surface,
                        foregroundColor: colorScheme.primary,
                        child: Text(
                          project.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        project.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.surface.withOpacity(0.8)
                        ),
                      ),
                      subtitle: Text(
                        'Stitches: ${project.stitch.count} | Rounds: ${project.round.count}',
                        style: TextStyle(
                          color: colorScheme.surface.withOpacity(0.6)// Even softer
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: colorScheme.surface.withOpacity(0.8)// Soft chevron
                      ),
                      onTap: () => _controller.navigateToProject(context, project),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              return AlertDialog(
                title: Text(
                  'New Project',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: colorScheme.onSurface,
                  ),
                ),
                backgroundColor: colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    labelStyle: TextStyle(
                      color: colorScheme.onSurfaceVariant,
                    ),
                    hintText: 'Enter project name',
                    hintStyle: TextStyle(
                      color: colorScheme.outline,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: colorScheme.outline,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _controller.addProject(nameController.text);
                      setState(() {});
                    },
                    child: Text(
                      'Create',
                      style: TextStyle(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}