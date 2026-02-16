// widgets/project_card.dart
import 'package:flutter/material.dart';
import 'package:stitchcounter/models/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Future<bool?> Function(DismissDirection) onConfirmDismiss;
  final Future<void> Function(DismissDirection) onDismissed;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onLongPress,
    required this.onConfirmDismiss,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onLongPress: onLongPress,
      child: Dismissible(
        key: Key(project.id),
        direction: DismissDirection.endToStart,
        background: Container(
          color: colorScheme.error,
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          child: Icon(Icons.delete, color: colorScheme.onError),
        ),
        confirmDismiss: onConfirmDismiss,
        onDismissed: onDismissed,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              project.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.surface.withOpacity(0.8),
              ),
            ),
            subtitle: Text(
              'Stitches: ${project.stitch.count} | Rounds: ${project.round.count}',
              style: TextStyle(color: colorScheme.surface.withOpacity(0.6)),
            ),
            trailing: Icon(
              Icons.chevron_right,
              color: colorScheme.surface.withOpacity(0.8),
            ),
            onTap: onTap,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
