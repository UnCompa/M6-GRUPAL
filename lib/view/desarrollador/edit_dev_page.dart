import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/desarrolador.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';

class EditDevPage extends StatefulWidget {
  final Desarrolador desarrolador;
  const EditDevPage({super.key, required this.desarrolador});

  @override
  State<EditDevPage> createState() => _EditDevPageState();
}

class _EditDevPageState extends State<EditDevPage> {
  late TextEditingController nombreController;
  late String rolController;
  late TextEditingController expController;
  late dynamic disponible;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.desarrolador.nombre);
    rolController = widget.desarrolador.rol;
    expController = TextEditingController(
      text: widget.desarrolador.experiencia.toString(),
    );
    disponible = widget.desarrolador.disponible;

    if (disponible == true) {
      disponible = "Disponible";
    } else if (disponible == false) {
      disponible = "No Disponible";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Actualizar Desarrolador")),
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
              controller: expController,
              decoration: const InputDecoration(labelText: "Nota"),
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
                  id: widget.desarrolador.id,
                  nombre: nombreController.text,
                  rol: rolController,
                  experiencia: int.parse(expController.text),
                  disponible: disponible,
                );
                await DatabaseHelper().updateDev(dev);
                Navigator.pop(context, true);
              },
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
