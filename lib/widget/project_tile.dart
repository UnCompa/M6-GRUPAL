import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';

class ProjectTile extends StatelessWidget {
  final Project project;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const ProjectTile({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.project,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(project.nombre),
        subtitle: Column(
          children: [
            Text(
              'Inicia: ${project.fechaInicio}\n ${project.descripcion}\nPresupuesto: ${project.presupuesto}',
            ),
            Text("Entregado: ${project.entregado}"),
            DropdownButtonFormField<String>(
              value: project.prioridad,
              decoration: InputDecoration(
                labelText: 'Prioridad',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: ['Pendiente', 'Completado'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
