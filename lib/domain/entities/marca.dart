import 'package:tabela_fipe_changenotifier/domain/entities/schemas/marca_schema.dart';

class Marca {
  final String codigo;
  final String nome;

  const Marca({
    required this.codigo,
    required this.nome,
  });

  factory Marca.fromMap(Map<String, dynamic> map){
    return Marca(
      codigo: map[MarcaSchema.marcaCodigo] as String,
      nome: map[MarcaSchema.marcaNome] as String,
    );
  }

}
