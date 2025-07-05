class Project {
  final String id;
  final String nombre;
  final String descripcion;
  final String fechaInicio;
  final double presupuesto;
  final bool entregado;
  final String prioridad;

  Project({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.fechaInicio,
    required this.presupuesto,
    required this.entregado,
    required this.prioridad,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'fechaInicio': fechaInicio,
      'presupuesto': presupuesto,
      'entregado': entregado,
      'prioridad': prioridad,
    };
  }
}
