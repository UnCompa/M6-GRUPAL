class Desarrolador {
  final String id;
  final String nombre;
  final String rol;
  final int experiencia;
  final bool disponible;

  Desarrolador({
    required this.id,
    required this.nombre,
    required this.rol,
    required this.experiencia,
    required this.disponible,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'rol': rol,
      'experiencia': experiencia,
      'disponible': disponible,
    };
  }
}
