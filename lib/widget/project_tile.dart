import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final VoidCallback onChecked;

  const ProjectTile({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.project,
    required this.onChecked,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      borderOnForeground: true,
      shadowColor: Colors.red,
      surfaceTintColor: Colors.red,
      child: ListTile(
        title: Text(project.nombre),
        subtitle: Text(
          'Descripcion: ${project.descripcion}\nInicia: ${project.fechaInicio}\nPresupuesto: ${project.presupuesto}\nPrioridad: ${project.prioridad}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                final projectUpdate = Project(
                  id: project.id,
                  nombre: project.nombre,
                  descripcion: project.descripcion,
                  fechaInicio: project.fechaInicio,
                  presupuesto: project.presupuesto,
                  entregado: !project.entregado,
                  prioridad: project.prioridad,
                );
                await DatabaseHelper().updateProject(projectUpdate);
                onChecked();
              },
              icon: project.entregado
                  ? Icon(Icons.check_circle)
                  : Icon(Icons.check_circle_outline),
              color: project.entregado ? Colors.green : Colors.grey,
            ),
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
              color: Colors.blue,
            ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
