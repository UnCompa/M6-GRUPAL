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
        backgroundColor: Colors.blue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tareas',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              child: Icon(Icons.refresh_rounded, color: Colors.white),
              onTap: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.people, color: Colors.green),
              title: Text('Desarrolladores'),
              onTap: () {
                Navigator.pushNamed(context, RoutesPage.homeDesarrolladores);
              },
            ),
            ListTile(
              leading: Icon(Icons.task, color: Colors.blue),
              title: Text('Tareas'),
              onTap: () {
                Navigator.pushNamed(context, RoutesPage.homeTareas);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.red),
              title: Text('Proyecto'),
              selected: true,
              selectedTileColor: Colors.red.shade50,
              onTap: () {
                Navigator.pushNamed(context, RoutesPage.homeProyectos);
              },
            ),
            const Spacer(),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '© 2025 Gestión de Equipos',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
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
