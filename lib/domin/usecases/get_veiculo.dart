import 'package:dartz/dartz.dart';
import '../entities/veiculo.dart';
import '../repositories/fipe_repository.dart';
import '../../core/error/failure.dart';

class GetVeiculo {
  final FipeRepository repository;

  GetVeiculo(this.repository);

  Future<Either<Failure, Veiculo>> call(String tipoVeiculo, String marcaCodigo, String modeloCodigo, String anoCodigo) async {
    return await repository.getVeiculo(tipoVeiculo, marcaCodigo, modeloCodigo, anoCodigo);
  }
}
