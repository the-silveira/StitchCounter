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

    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
     appBar: AppBar(
  title: const Text('My Projects'),
  backgroundColor: Theme.of(context).colorScheme.primary,
  foregroundColor: Theme.of(context).colorScheme.onPrimary,
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
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No projects yet',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to create your first project',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.outline.withOpacity(0.7),
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
                    color: Theme.of(context).colorScheme.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Theme.of(context).colorScheme.onError),
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
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        child: Text(
                          project.name[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        project.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                      subtitle: Text(
                        'Stitches: ${project.stitch.count} | Rounds: ${project.round.count}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      trailing: Icon(
                        Icons.chevron_right,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                backgroundColor: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                content: TextField(
                  controller: nameController,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                    hintText: 'Enter project name',
                    hintStyle: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  ),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
   
    
    );
  }
}