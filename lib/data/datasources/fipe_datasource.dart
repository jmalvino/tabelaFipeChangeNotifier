import 'package:http/http.dart' as http;
import 'package:tabela_fipe_changenotifier/domin/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/veiculo.dart';
import 'dart:convert';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

class FipeDataSource {
  final http.Client client;

  FipeDataSource(this.client);

  Future<Either<Failure, List<Marca>>> getMarcas(String tipoVeiculo) async {
    final url = Uri.parse('https://parallelum.com.br/fipe/api/v1/$tipoVeiculo/marcas');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Marca> marcas = data.map((json) => Marca(codigo: json['codigo'], nome: json['nome'])).toList();
        return Right(marcas);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Modelo>>> getModelos(String tipoVeiculo, String marcaCodigo) async {
    final url = Uri.parse('https://parallelum.com.br/fipe/api/v1/$tipoVeiculo/marcas/$marcaCodigo/modelos');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final List<dynamic> modelosData = data['modelos'];
        final List<Modelo> modelos = modelosData.map((json) => Modelo(codigo: json['codigo'].toString(), nome: json['nome'])).toList();
        return Right(modelos);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, List<Ano>>> getAnos(String tipoVeiculo, String marcaCodigo, String modeloCodigo) async {
    final url = Uri.parse('https://parallelum.com.br/fipe/api/v1/$tipoVeiculo/marcas/$marcaCodigo/modelos/$modeloCodigo/anos');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final List<Ano> anos = data.map((json) => Ano(codigo: json['codigo'], nome: json['nome'])).toList();
        return Right(anos);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Veiculo>> getVeiculo(String tipoVeiculo, String marcaCodigo, String modeloCodigo, String anoCodigo) async {
    final url = Uri.parse('https://parallelum.com.br/fipe/api/v1/$tipoVeiculo/marcas/$marcaCodigo/modelos/$modeloCodigo/anos/$anoCodigo');
    try {
      final response = await client.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final veiculo = Veiculo(
          tipoVeiculo: data['TipoVeiculo'].toString(),
          valor: data['Valor'],
          marca: data['Marca'],
          modelo: data['Modelo'],
          anoModelo: data['AnoModelo'],
          combustivel: data['Combustivel'],
          codigoFipe: data['CodigoFipe'],
          mesReferencia: data['MesReferencia'],
          siglaCombustivel: data['SiglaCombustivel'],
        );
        return Right(veiculo);
      } else {
        return Left(ServerFailure());
      }
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
