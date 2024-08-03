import 'package:flutter/material.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/veiculo.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_anos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_marcas.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_modelos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_veiculo.dart';
import '../../core/error/failure.dart';

class FipeChangeNotifier extends ChangeNotifier {
  final GetMarcas getMarcas;
  final GetModelos getModelos;
  final GetAnos getAnos;
  final GetVeiculo getVeiculo;

  FipeChangeNotifier({
    required this.getMarcas,
    required this.getModelos,
    required this.getAnos,
    required this.getVeiculo,
  });

  String _tipoVeiculo = 'carros';
  List<Marca> _marcas = [];
  List<Modelo> _modelos = [];
  List<Ano> _anos = [];
  Veiculo? _veiculo;
  String? _errorMessage;

  List<Marca> get marcas => _marcas;
  List<Modelo> get modelos => _modelos;
  List<Ano> get anos => _anos;
  Veiculo? get veiculo => _veiculo;
  String? get errorMessage => _errorMessage;

  void changeVehicleType(String tipo) {
    _tipoVeiculo = tipo;
    notifyListeners();
    fetchMarcas();
  }

  Future<void> fetchMarcas() async {
    final result = await getMarcas(_tipoVeiculo);
    result.fold(
          (failure) => _handleError(failure),
          (marcas) {
        _marcas = marcas;
        _modelos = [];
        _anos = [];
        _veiculo = null;
        notifyListeners();
      },
    );
  }

  Future<void> fetchModelos(String marcaCodigo) async {
    final result = await getModelos(_tipoVeiculo, marcaCodigo);
    result.fold(
          (failure) => _handleError(failure),
          (modelos) {
        _modelos = modelos;
        _anos = [];
        _veiculo = null;
        notifyListeners();
      },
    );
  }

  Future<void> fetchAnos(String marcaCodigo, String modeloCodigo) async {
    final result = await getAnos(_tipoVeiculo, marcaCodigo, modeloCodigo);
    result.fold(
          (failure) => _handleError(failure),
          (anos) {
        _anos = anos;
        _veiculo = null;
        notifyListeners();
      },
    );
  }

  Future<void> fetchVeiculo(String marcaCodigo, String modeloCodigo, String anoCodigo) async {
    final result = await getVeiculo(_tipoVeiculo, marcaCodigo, modeloCodigo, anoCodigo);
    result.fold(
          (failure) => _handleError(failure),
          (veiculo) {
        _veiculo = veiculo;
        notifyListeners();
      },
    );
  }

  void _handleError(Failure failure) {
    if (failure is ServerFailure) {
      _errorMessage = 'Erro ao acessar a API. Tente novamente.';
    } else {
      _errorMessage = 'Erro desconhecido.';
    }
    notifyListeners();
  }
}
