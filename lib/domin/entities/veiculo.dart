import 'package:tabela_fipe_changenotifier/domin/entities/schemas/veiculo_schema.dart';

class Veiculo {
  final String tipoVeiculo;
  final String valor;
  final String marca;
  final String modelo;
  final int anoModelo;
  final String combustivel;
  final String codigoFipe;
  final String mesReferencia;
  final String siglaCombustivel;

  const Veiculo({
    required this.tipoVeiculo,
    required this.valor,
    required this.marca,
    required this.modelo,
    required this.anoModelo,
    required this.combustivel,
    required this.codigoFipe,
    required this.mesReferencia,
    required this.siglaCombustivel,
  });

  factory Veiculo.fromMap(Map<String, dynamic> map) {
    return Veiculo(
      tipoVeiculo: map[VeiculoSchema.veiculoTipoVeiculo] as String,
      valor: map[VeiculoSchema.veiculoValor] as String,
      marca: map[VeiculoSchema.veiculoMarca] as String,
      modelo: map[VeiculoSchema.veiculoModelo] as String,
      anoModelo: map[VeiculoSchema.veiculoAnoModelo] as int,
      combustivel: map[VeiculoSchema.veiculoCombustivel] as String,
      codigoFipe: map[VeiculoSchema.veiculoCodigoFipe] as String,
      mesReferencia: map[VeiculoSchema.veiculoMesReferencia] as String,
      siglaCombustivel: map[VeiculoSchema.veiculoCombustivel] as String,
    );
  }
}
