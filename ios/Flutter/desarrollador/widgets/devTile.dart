import 'package:flutter/material.dart';
import 'package:gestion_equipos/desarrollador/models/desarrolador.dart';

class Devtile extends StatelessWidget {
  final Desarrolador dev;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const Devtile({
    super.key,
    required this.dev,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text(dev.nombre),
        subtitle: Text("${dev.rol} - ${dev.experiencia}"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
            IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
            Icon(
              dev.disponible ? Icons.check_circle : Icons.check_circle_outline,
              color: dev.disponible ? Colors.green : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
