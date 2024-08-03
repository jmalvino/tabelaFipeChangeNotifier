import 'package:dartz/dartz.dart';
import '../entities/marca.dart';
import '../repositories/fipe_repository.dart';
import '../../core/error/failure.dart';

class GetMarcas {
  final FipeRepository repository;

  GetMarcas(this.repository);

  Future<Either<Failure, List<Marca>>> call(String tipoVeiculo) async {
    return await repository.getMarcas(tipoVeiculo);
  }
}
