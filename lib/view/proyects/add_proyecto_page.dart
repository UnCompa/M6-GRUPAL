import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';

class AddProjectPage extends StatefulWidget {
  const AddProjectPage({super.key});

  @override
  State<AddProjectPage> createState() => _AddProjectPageState();
}

class _AddProjectPageState extends State<AddProjectPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _presupuestoController = TextEditingController();
  bool _entregadoController = false;
  String _prioridadController = 'Alta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Crear proyecto',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
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
                  value: _prioridadController,
                  items: ['Alta', 'Media', 'Baja'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _prioridadController = newValue!;
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
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  nombre: _nombreController.text,
                  descripcion: _descriptionController.text,
                  fechaInicio: _fechaInicioController.text,
                  presupuesto: double.parse(_presupuestoController.text),
                  entregado: _entregadoController,
                  prioridad: _prioridadController,
                );
                print(project.toMap());
                await DatabaseHelper().insertProject(project);
                Navigator.pop(context, true);
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
