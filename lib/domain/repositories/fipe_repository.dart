import 'package:dartz/dartz.dart';
import '../entities/marca.dart';
import '../entities/modelo.dart';
import '../entities/ano.dart';
import '../entities/veiculo.dart';
import '../../core/error/failure.dart';

abstract class FipeRepository {
  Future<Either<Failure, List<Marca>>> getMarcas(String tipoVeiculo);

  Future<Either<Failure, List<Modelo>>> getModelos(
      String tipoVeiculo, String marcaCodigo);

  Future<Either<Failure, List<Ano>>> getAnos(
      String tipoVeiculo, String marcaCodigo, String modeloCodigo);

  Future<Either<Failure, Veiculo>> getVeiculo(String tipoVeiculo,
      String marcaCodigo, String modeloCodigo, String anoCodigo);
}
