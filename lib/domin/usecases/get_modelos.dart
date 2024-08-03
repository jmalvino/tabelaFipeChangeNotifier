import 'package:dartz/dartz.dart';
import '../entities/modelo.dart';
import '../repositories/fipe_repository.dart';
import '../../core/error/failure.dart';

class GetModelos {
  final FipeRepository repository;

  GetModelos(this.repository);

  Future<Either<Failure, List<Modelo>>> call(String tipoVeiculo, String marcaCodigo) async {
    return await repository.getModelos(tipoVeiculo, marcaCodigo);
  }
}
