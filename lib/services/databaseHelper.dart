import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestion_equipos/models/desarrolador.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:gestion_equipos/models/tarea.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _projectCollection = _firestore.collection(
    'project',
  );

  static final CollectionReference _devCollection = _firestore.collection(
    'desarroladores',
  );
  static final CollectionReference _tareasCollection = _firestore.collection(
    'tareas',
  );

  Future<void> insertTarea(Tareas tarea) async {
    await _tareasCollection.add(tarea.toMap());
  }

  Future<List<Tareas>> getTareas() async {
    final QuerySnapshot snapshot = await _tareasCollection.get();
    return snapshot.docs.map((doc) => Tareas.fromFirestore(doc)).toList();
  }

  Future<void> updateTarea(Tareas tarea, String docId) async {
    await _tareasCollection.doc(docId).update(tarea.toMap());
  }

  Future<void> deleteTarea(String docId) async {
    await _tareasCollection.doc(docId).delete();
  }

  Future<void> insertDev(Desarrolador dev) async {
    await _devCollection.add(dev.toMap());
  }

  Future<List<Desarrolador>> getDev() async {
    final snapshot = await _firestore.collection("desarroladores").get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final bool disponible = data['disponible'] ?? false;

      return Desarrolador(
        id: doc.id,
        nombre: data["nombre"] ?? "",
        rol: data["rol"] ?? "",
        experiencia: data["experiencia"] ?? 0,
        disponible: disponible,
      );
    }).toList();
  }

  Future<void> updateDev(Desarrolador dev) async {
    await _devCollection.doc(dev.id).update(dev.toMap());
  }

  Future<void> deleteDev(String id) async {
    await _devCollection.doc(id).delete();
  }

  Future<void> insertProject(Project dev) async {
    await _projectCollection.add(dev.toMap());
  }

  Future<List<Project>> getAllProjects() async {
    final snapshot = await _firestore.collection('project').get();
    return snapshot.docs.map((doc) {
      final double presupuesto = doc.data()['presupuesto']?.toDouble() ?? 0.0;
      return Project(
        id: doc.id,
        nombre: doc.data()['nombre'] ?? '',
        descripcion: doc.data()['descripcion'] ?? '',
        entregado: doc.data()['entregado'] ?? false,
        fechaInicio: doc.data()['fechaInicio'] ?? '',
        presupuesto: presupuesto,
        prioridad: doc.data()['prioridad'] ?? 'Alta',
      );
    }).toList();
  }

  Future<void> updateProject(Project project) async {
    await _projectCollection.doc(project.id).update(project.toMap());
  }

  Future<void> deleteProject(String id) async {
    await _projectCollection.doc(id).delete();
  }
}
