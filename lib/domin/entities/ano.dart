import 'package:tabela_fipe_changenotifier/domin/entities/schemas/ano_schema.dart';

///Passar os mapper pra ca
class Ano {
  final String codigo;
  final String nome;

  const Ano({
    required this.codigo,
    required this.nome,
  });

  factory Ano.fromMap(Map<String, dynamic> map) {
    return Ano(
      codigo: map[AnoSchema.anoCodigo] as String,
      nome: map[AnoSchema.anoNome] as String,
    );
  }
}
