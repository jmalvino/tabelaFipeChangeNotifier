import 'package:dartz/dartz.dart';
import '../entities/ano.dart';
import '../repositories/fipe_repository.dart';
import '../../core/error/failure.dart';

class GetAnos {
  final FipeRepository repository;

  GetAnos(this.repository);

  Future<Either<Failure, List<Ano>>> call(String tipoVeiculo, String marcaCodigo, String modeloCodigo) async {
    return await repository.getAnos(tipoVeiculo, marcaCodigo, modeloCodigo);
  }
}
