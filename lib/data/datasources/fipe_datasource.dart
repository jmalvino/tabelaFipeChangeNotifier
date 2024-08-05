import 'package:tabela_fipe_changenotifier/domain/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/schemas/veiculo_schema.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/veiculo.dart';
import 'dart:convert';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class FipeDataSource {
  final http.Client client;

  FipeDataSource(this.client);
/// refazer
  final String _urlBase = 'https://parallelum.com.br/fipe/api/v1';

  Future<Either<Failure, List<Marca>>> getMarcas(String tipoVeiculo) async {
    final url = Uri.parse('$_urlBase/$tipoVeiculo/marcas');
    try {
      final response = await client.get(url);

      final List<dynamic> data = json.decode(response.body);
      final List<Marca> marcas = data
          .map((json) => Marca(codigo: json['codigo'], nome: json['nome']))
          .toList();
      return Right(marcas);
    } catch (e) {
      return Left(ServerFailure('Ocorreu um erro ao recuperar a lista'));
    }
  }

  Future<Either<Failure, List<Modelo>>> getModelos(
      String tipoVeiculo, String marcaCodigo) async {
    final url = Uri.parse(
      '$_urlBase/$tipoVeiculo/marcas/$marcaCodigo/modelos',
    );
    try {
      final response = await client.get(url);

      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> modelosData = data['modelos'];
      final List<Modelo> modelos = modelosData
          .map((json) =>
              Modelo(codigo: json['codigo'].toString(), nome: json['nome']))
          .toList();
      return Right(modelos);
    } catch (e) {
      return Left(ServerFailure('Ocorreu um erro ao recuperar a lista'));
    }
  }

  Future<Either<Failure, List<Ano>>> getAnos(
    String tipoVeiculo,
    String marcaCodigo,
    String modeloCodigo,
  ) async {
    final url = Uri.parse(
      '$_urlBase/$tipoVeiculo/marcas/$marcaCodigo/modelos/$modeloCodigo/anos',
    );
    try {
      final response = await client.get(url);

      final List<dynamic> data = json.decode(response.body);
      final List<Ano> anos = data
          .map((json) => Ano.fromMap(json))
          .toList();
      return Right(anos);
    } catch (e) {
      return Left(ServerFailure('Ocorreu um erro ao recuperar a lista'));
    }
  }

  Future<Either<Failure, Veiculo>> getVeiculo(
    String tipoVeiculo,
    String marcaCodigo,
    String modeloCodigo,
    String anoCodigo,
  ) async {
    final url = Uri.parse(
        '$_urlBase/$tipoVeiculo/marcas/$marcaCodigo/modelos/$modeloCodigo/anos/$anoCodigo');
    try {
      final response = await client.get(url);

      final data = json.decode(response.body);
      final veiculo = Veiculo(
        tipoVeiculo: data[VeiculoSchema.veiculoTipoVeiculo].toString(),
        valor: data[VeiculoSchema.veiculoValor],
        marca: data[VeiculoSchema.veiculoMarca],
        modelo: data[VeiculoSchema.veiculoModelo],
        anoModelo: data[VeiculoSchema.veiculoAnoModelo],
        combustivel: data[VeiculoSchema.veiculoCombustivel],
        codigoFipe: data[VeiculoSchema.veiculoCodigoFipe],
        mesReferencia: data[VeiculoSchema.veiculoMesReferencia],
        siglaCombustivel: data[VeiculoSchema.veiculoSiglaCombustivel],
      );
      return Right(veiculo);
    } catch (e) {
      return Left(ServerFailure('Ocorreu um erro ao recuperar a lista'));
    }
  }
}
