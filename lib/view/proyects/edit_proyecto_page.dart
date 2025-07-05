import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/services/database_helper.dart';

class EditProyectoPage extends StatefulWidget {
  final Project project;
  const EditProyectoPage({super.key, required this.project});

  @override
  State<EditProyectoPage> createState() => _EditProyectoPageState();
}

class _EditProyectoPageState extends State<EditProyectoPage> {
  late TextEditingController _nombreController;
  late TextEditingController _descriptionController;
  late TextEditingController _fechaInicioController;
  late TextEditingController _presupuestoController;
  late TextEditingController _entregadoController;
  late TextEditingController _prioridadController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Libro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Autor'),
            ),
            DropdownButton<String>(
              value: _prioridadController.text,
              items: ['Alta', 'Media', 'Baja'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _prioridadController.text = newValue!;
                });
              },
            ),
            TextField(
              controller: _fechaInicioController,
              decoration: InputDecoration(labelText: 'Nota'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final project = Project(
                  id: widget.project.id,
                  nombre: _nombreController.text,
                  descripcion: _descriptionController.text,
                  fechaInicio: _fechaInicioController.text,
                  presupuesto: double.parse(_presupuestoController.text),
                  entregado: bool.parse(_entregadoController.text),
                  prioridad: _prioridadController.text,
                );
                await DatabaseHelper().updateProject(project);
                Navigator.pop(context, true);
              },
              child: Text('Editar'),
            ),
          ],
        ),
      ),
    );
  }
}
