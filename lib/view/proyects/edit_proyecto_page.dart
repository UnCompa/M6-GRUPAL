import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';

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
  late bool _entregadoController;
  late TextEditingController _prioridadController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.project.nombre);
    _descriptionController = TextEditingController(
      text: widget.project.descripcion,
    );
    _fechaInicioController = TextEditingController(
      text: widget.project.fechaInicio,
    );

    _prioridadController = TextEditingController(
      text: widget.project.prioridad,
    );
    _presupuestoController = TextEditingController(
      text: widget.project.presupuesto.toString(),
    );
    _entregadoController = widget.project.entregado;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Proyecto'),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(
                labelText: 'Nombre',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cursorColor: Colors.red,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cursorColor: Colors.red,
              keyboardType: TextInputType.text,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Prioridad"),
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
              ],
            ),
            TextFormField(
              controller: _fechaInicioController,
              decoration: InputDecoration(
                labelText: 'Fecha de Inicio',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              cursorColor: Colors.red,
              keyboardType: TextInputType.datetime,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'La fecha de inicio es requerida';
                }
                return null;
              },
              onTap: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    _fechaInicioController.text =
                        "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                  });
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _presupuestoController,
              decoration: InputDecoration(
                labelText: 'Presupuesto',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.numberWithOptions(
                decimal: true,
                signed: false,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  checkColor: Colors.white,
                  fillColor: MaterialStateProperty.all<Color>(Colors.red),
                  value: _entregadoController,
                  onChanged: (bool? value) {
                    setState(() {
                      _entregadoController = value!;
                    });
                  },
                ),
                Text("Entregado"),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
              onPressed: () async {
                final project = Project(
                  id: widget.project.id,
                  nombre: _nombreController.text,
                  descripcion: _descriptionController.text,
                  fechaInicio: _fechaInicioController.text,
                  presupuesto: double.parse(_presupuestoController.text),
                  entregado: _entregadoController,
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
