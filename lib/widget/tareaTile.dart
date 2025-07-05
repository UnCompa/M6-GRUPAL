import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/tarea.dart';

class TareaTile extends StatelessWidget {
  final Tareas tarea;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TareaTile({
    Key? key,
    required this.tarea,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(tarea.titulo),
        subtitle: Text(
          'Descripción: ${tarea.descripcion}\n'
          'Nivel: ${tarea.nivel} | Urgencia: ${tarea.urgencia}\n'
          'Fecha entrega: ${tarea.fechaEntrega}\n'
          'Completada: ${tarea.completada}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
          ],
        ),
      ),
    );
  }
}
