import 'package:flutter/material.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/routes/routes.dart';
import 'package:gestion_equipos/services/database_helper.dart';
import 'package:gestion_equipos/view/proyects/edit_proyecto_page.dart';
import 'package:gestion_equipos/widget/project_tile.dart';

class HomePageProyects extends StatefulWidget {
  const HomePageProyects({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageProyectsState();
}

class _HomePageProyectsState extends State<HomePageProyects> {
  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _projectList = DatabaseHelper().getProjects();
    });
  }

  void _deleteProject(String id) async {
    await DatabaseHelper().deleteProject(id);
    _refreshList();
  }

  late Future<List<Project>> _projectList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Proyectos',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              child: Icon(Icons.refresh_rounded, color: Colors.white),
              onTap: _refreshList,
            ),
          ],
        ),
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
            ),
            GestureDetector(
              child: Text("Tareas 🗒️", style: TextStyle(color: Colors.white)),
            ),
            GestureDetector(
              child: Text("Proyecto ⚙️", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<List<Project>>(
              future: _projectList,
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Hay Proyectos'));
                } else {
                  return ListView(
                    children: snapshot.data!
                        .map(
                          (project) => ProjectTile(
                            project: project,
                            onDelete: () => _deleteProject,
                            onEdit: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      EditProyectoPage(project: project),
                                ),
                              );
                              if (result == true) {
                                _refreshList();
                              }
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            RoutesPage.addProyecto,
          );
          if (result == true) {
            _refreshList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
