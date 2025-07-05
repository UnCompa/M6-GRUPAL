import 'package:cloud_firestore/cloud_firestore.dart';

class Tareas {
  final int id;
  final String titulo;
  final String descripcion;
  final String fechaEntrega;
  final int nivel;
  final String completada;
  final String urgencia;
  Tareas({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.fechaEntrega,
    required this.nivel,
    required this.completada,
    required this.urgencia,
  });

  Map<String, dynamic> toMap() {
    return {
      "titulo": titulo,
      "descripcion": descripcion,
      "fechaEntrega": fechaEntrega,
      "nivel": nivel,
      "completada": completada,
      "urgencia": urgencia,
    };
  }

  factory Tareas.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tareas(
      id: data['id'] ?? 0,
      titulo: data['titulo'] ?? '',
      descripcion: data['descripcion'] ?? '',
      fechaEntrega: data['fechaEntrega'] ?? '',
      nivel: data['nivel'] ?? 1,
      completada: data['completada']?.toString() ?? 'false',
      urgencia: data['urgencia'] ?? '',
    );
  }
}
