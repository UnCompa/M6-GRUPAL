import 'package:flutter/material.dart';
import 'package:gestion_equipos/routes/routes.dart';
import 'package:gestion_equipos/view/desarrollador/add_dev_page.dart';
import 'package:gestion_equipos/view/desarrollador/home_page.dart';
import 'package:gestion_equipos/view/proyects/add_proyecto_page.dart';
import 'package:gestion_equipos/view/proyects/home_proyectos_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gestion_equipos/view/tasks/home_tarea.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageProyects(),
      routes: {
        RoutesPage.homeProyectos: (context) => const HomePageProyects(),
        RoutesPage.addProyecto: (context) => const AddProjectPage(),
        RoutesPage.homeDesarrolladores: (context) => const HomePageDev(),
        RoutesPage.addDesarrollador: (context) => const AddDevPage(),
        RoutesPage.homeTareas: (context) => const HomePageTarea(),
      },
    );
  }
}
