import 'package:gestion_equipos/models/desarrolador.dart';
import 'package:gestion_equipos/routes/routes.dart';
import 'package:gestion_equipos/services/databaseHelper.dart';
import 'package:gestion_equipos/view/desarrollador/edit_dev_page.dart';
import 'package:gestion_equipos/widget/devTile.dart';

import 'package:flutter/material.dart';

class HomePageDev extends StatefulWidget {
  const HomePageDev({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageDev> {
  late Future<List<Desarrolador>> _devList;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() async {
    setState(() {
      _devList = DatabaseHelper().getDev();
    });
  }

  void _deletDev(String id) async {
    await DatabaseHelper().deleteDev(id);
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Desarrolladores',
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
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            ListTile(
              leading: Icon(Icons.people, color: Colors.green),
              title: Text('Desarrolladores'),
              selected: true,
              selectedTileColor: Colors.green.shade50,
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
      body: FutureBuilder<List<Desarrolador>>(
        future: _devList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay Desarrolladores.'));
          } else {
            return ListView(
              children: snapshot.data!
                  .map(
                    (dev) => Devtile(
                      dev: dev,
                      onDelete: () => _deletDev(dev.id),
                      onEdit: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => EditDevPage(desarrolador: dev),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            RoutesPage.addDesarrollador,
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
