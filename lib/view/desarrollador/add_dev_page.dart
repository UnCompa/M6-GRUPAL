import 'package:gestion_equipos/models/desarrolador.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';

import 'package:flutter/material.dart';

class AddDevPage extends StatefulWidget {
  const AddDevPage({super.key});

  @override
  State<AddDevPage> createState() => _AddDevPageState();
}

class _AddDevPageState extends State<AddDevPage> {
  final nombreController = TextEditingController();
  String rolController = "Frontend";
  final xpController = TextEditingController();
  dynamic disponible = "Disponible";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agregar Desarrolador")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            DropdownButton<String>(
              value: rolController,
              items: [
                "Frontend",
                "Backend",
                "QA",
                "Diseño",
                "DevOps",
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => rolController = val!),
            ),
            TextField(
              controller: xpController,
              decoration: const InputDecoration(labelText: "Experiencia"),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: disponible,
              items: [
                "Disponible",
                "No Disponible",
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (val) => setState(() => disponible = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (disponible == "Disponible") {
                  disponible = true;
                } else if (disponible == "No Disponible") {
                  disponible = false;
                }

                final dev = Desarrolador(
                  id: "",
                  nombre: nombreController.text,
                  rol: rolController,
                  experiencia: int.parse(xpController.text),
                  disponible: disponible,
                );
                await DatabaseHelper().insertDev(dev);
                Navigator.pop(context, true);
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
