import 'package:dartz/dartz.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/veiculo.dart';
import 'package:tabela_fipe_changenotifier/domain/repositories/fipe_repository.dart';
import '../../core/error/failure.dart';
import '../datasources/fipe_datasource.dart';

class FipeRepositoryImpl implements FipeRepository {
  final FipeDataSource dataSource;

  FipeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<Marca>>> getMarcas(String tipoVeiculo) {
    return dataSource.getMarcas(tipoVeiculo);
  }

  @override
  Future<Either<Failure, List<Modelo>>> getModelos(String tipoVeiculo, String marcaCodigo) {
    return dataSource.getModelos(tipoVeiculo, marcaCodigo);
  }

  @override
  Future<Either<Failure, List<Ano>>> getAnos(String tipoVeiculo, String marcaCodigo, String modeloCodigo) {
    return dataSource.getAnos(tipoVeiculo, marcaCodigo, modeloCodigo);
  }

  @override
  Future<Either<Failure, Veiculo>> getVeiculo(String tipoVeiculo, String marcaCodigo, String modeloCodigo, String anoCodigo) {
    return dataSource.getVeiculo(tipoVeiculo, marcaCodigo, modeloCodigo, anoCodigo);
  }
}
