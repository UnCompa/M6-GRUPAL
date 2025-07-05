import '../models/desarrolador.dart';
import '../services/database_helper.dart';
import '../views/edit_dev_page.dart';
import '../widgets/devTile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Desarrolador>> _devList;

  @override
  void initState() {
    super.initState();
    _refreshList();
  }

  void _refreshList() {
    setState(() {
      _devList = DatabaseHelper().getDev();
    });
  }

  void _deleteBook(String id) async {
    await DatabaseHelper().deleteDev(id);
    _refreshList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Biblioteca')),
      body: FutureBuilder<List<Desarrolador>>(
        future: _devList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay Desarroladores.'));
          } else {
            return ListView(
              children: snapshot.data!
                  .map(
                    (dev) => Devtile(
                      dev: dev,
                      onDelete: () => _deleteBook(dev.id),
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
        onPressed: () async {
          final result = await Navigator.pushNamed(context, "/add");
          if (result == true) {
            _refreshList();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
