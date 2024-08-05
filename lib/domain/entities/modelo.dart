import 'package:tabela_fipe_changenotifier/domain/entities/schemas/modelo_schema.dart';

class Modelo {
  final String codigo;
  final String nome;

  const Modelo({
    required this.codigo,
    required this.nome,
  });

  factory Modelo.fromMap(Map<String, dynamic> map) {
    return Modelo(
      codigo: map[ModeloSchema.modeloCodigo] as String,
      nome: map[ModeloSchema.modeloNome] as String,
    );
  }
}
