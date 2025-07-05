import 'package:gestion_equipos/models/desarrolador.dart';
import 'package:gestion_equipos/models/project.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final CollectionReference _devCollection = _firestore.collection(
    'desarroladores',
  );
  static final CollectionReference _projectCollection = _firestore.collection(
    'project',
  );

  Future<void> insertDev(Desarrolador dev) async {
    await _devCollection.add(dev.toMap());
  }

  Future<List<Desarrolador>> getDev() async {
    final snapshot = await _devCollection.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final bool disponible = data['disponible'] ?? false;

      return Desarrolador(
        id: doc.id,
        nombre: data["nombre"] ?? "",
        rol: data["rol"] ?? "",
        experiencia: data["experiencia"] ?? "",
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
    await _devCollection.add(dev.toMap());
  }

  Future<List<Project>> getProjects() async {
    final snapshot = await _projectCollection.get();

    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return Project(
        id: doc.id,
        nombre: data["nombre"] ?? "",
        descripcion: data["descripcion"] ?? "",
        fechaInicio: data["fechaInicio"] ?? "",
        presupuesto: data["presupuesto"] ?? 0.0,
        prioridad: data["prioridad"] ?? "",
        entregado: data['entregado'] ?? false,
      );
    }).toList();
  }

  Future<void> updateProject(Project dev) async {
    await _projectCollection.doc(dev.id).update(dev.toMap());
  }

  Future<void> delelte(String id) async {
    await _projectCollection.doc(id).delete();
  }
}
