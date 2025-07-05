import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/tarea.dart';
import 'package:gestion_equipos/routes/routes.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';
import 'package:gestion_equipos/view/tasks/addTarea_page.dart';
import 'package:gestion_equipos/view/tasks/editTarea_page.dart';
import 'package:gestion_equipos/widget/tareaTile.dart';

class HomePageTarea extends StatefulWidget {
  const HomePageTarea({super.key});

  @override
  State<HomePageTarea> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageTarea> {
  Future<List<Tareas>> _loadTareas() async {
    return await DatabaseHelper().getTareas();
  }

  Future<void> _deleteTarea(String docId) async {
    await DatabaseHelper().deleteTarea(docId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tareas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recargar lista',
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Text(
                "Desarrolladores 💻",
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pushNamed(context, RoutesPage.homeDesarrolladores);
              },
            ),
            GestureDetector(
              child: Text("Tareas 🗒️", style: TextStyle(color: Colors.white)),
            ),
            GestureDetector(
              child: Text("Proyecto ⚙️", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, RoutesPage.homeProyectos);
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<Tareas>>(
        future: _loadTareas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay tareas'));
          } else {
            final tareas = snapshot.data!;
            return ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return TareaTile(
                  tarea: tarea,
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTareaPage(tarea: tarea),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  onDelete: () async {
                    await _deleteTarea(tarea.docId);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTareaPage()),
          ).then((_) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
