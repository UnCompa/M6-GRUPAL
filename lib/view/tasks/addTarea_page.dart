import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestion_equipos/models/tarea.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';
import 'package:intl/intl.dart';

class AddTareaPage extends StatefulWidget {
  const AddTareaPage({super.key});

  @override
  State<StatefulWidget> createState() => AddTareaPageState();
}

class AddTareaPageState extends State {
  final descripcionController = TextEditingController();
  final tituloController = TextEditingController();
  final fechaEntrega = TextEditingController();
  final niveldescripcionController = TextEditingController();
  final completadadescripcionController = TextEditingController();
  String urgencia = "Alta";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void insertTarea() async {
      if (_formKey.currentState!.validate()) {
        final tarea = Tareas(
          docId: '',
          id: 0,
          titulo: tituloController.text,
          descripcion: descripcionController.text,
          fechaEntrega: fechaEntrega.text,
          nivel: int.parse(niveldescripcionController.text),
          completada: completadadescripcionController.text,
          urgencia: urgencia,
        );
        await DatabaseHelper().insertTarea(tarea);
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Debe llenar todos los campos")));
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Registro de tareas")),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: tituloController,
                decoration: InputDecoration(
                  labelText: "Titutlo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe el titulo";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: descripcionController,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe especificar la descripcion";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: fechaEntrega,
                decoration: InputDecoration(
                  labelText: "Fecha de Entrega",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe especificar la descripcion";
                  } else {
                    try {
                      DateFormat("dd/MM/yyyy").parse(value);
                      return null;
                    } catch (e) {
                      return "Fecha debe ser en formato dd/MM/yyyy";
                    }
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: niveldescripcionController,
                decoration: InputDecoration(
                  labelText: "Nivel",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe especificar el nivel";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: completadadescripcionController,
                decoration: InputDecoration(
                  labelText: "Completada",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Debe especificar el nivel";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 20),
              DropdownButton(
                value: urgencia,
                items: ["Alta", "Media", "Baja"]
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    urgencia = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  insertTarea();
                },
                child: Text("Guardar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
