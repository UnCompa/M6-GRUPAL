class Desarrolador {
  String id;
  String nombre;
  String rol;
  int experiencia;
  bool disponible;

  Desarrolador({
    required this.id,
    required this.nombre,
    required this.rol,
    required this.experiencia,
    required this.disponible,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'rol': rol,
      'experiencia': experiencia,
      'disponible': disponible,
    };
  }
}
