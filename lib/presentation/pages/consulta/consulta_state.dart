import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabela_fipe_changenotifier/core/error/failure.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/veiculo.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_anos.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_marcas.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_modelos.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_veiculo.dart';

class ConsultaState extends ChangeNotifier {
  final GetMarcas getMarcas;
  final GetModelos getModelos;
  final GetAnos getAnos;
  final GetVeiculo getVeiculo;
  final String tipoVeiculo;

  ConsultaState({
    required this.getMarcas,
    required this.getModelos,
    required this.getAnos,
    required this.getVeiculo,
    required this.tipoVeiculo,
  });

  String _tipoVeiculo = '';
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

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  String? _selectedMarca;

  String? get selectedMarca => _selectedMarca;

  set selectedMarca(String? value) {
    _selectedMarca = value;
    setModelo = null;
    selectedAnoNotifier.value = null;
  }

  String? _selectedModelo;

  String? get selectedModelo => _selectedModelo;

  set setModelo(String? value) {
    _selectedModelo = value;
    selectedAnoNotifier.value = null;
  }

  ValueNotifier<String?> selectedAnoNotifier = ValueNotifier(null);

  String? get selectAno => selectedAnoNotifier.value;

  set selectedAno(String? value) {
    selectedAnoNotifier.value = value;
    validateFormComplete();
    notifyListeners();
  }

  void changeVehicleType(String tipo) {
    _tipoVeiculo = tipo;
    fetchMarcas();
    notifyListeners();
  }

  Future<void> fetchMarcas() async {
    isLoading.value = true;
    final result = await getMarcas(_tipoVeiculo);
    isLoading.value = false;
    result.fold(
      (failure) => _handleError(failure),
      (marcas) {
        _marcas = marcas;
        _modelos = [];
        _anos = [];
        _veiculo = null;
      },
    );
    notifyListeners();
  }

  Future<void> fetchModelos(String marcaCodigo) async {
    isLoading.value = true;
    final result = await getModelos(_tipoVeiculo, marcaCodigo);
    isLoading.value = false;
    result.fold(
      (failure) => _handleError(failure),
      (modelos) {
        _modelos = modelos;
        _anos = [];
        _veiculo = null;
      },
    );
    notifyListeners();
  }

  Future<void> fetchAnos(String marcaCodigo, String modeloCodigo) async {
    isLoading.value = true;
    final result = await getAnos(_tipoVeiculo, marcaCodigo, modeloCodigo);
    isLoading.value = false;
    result.fold(
      (failure) => _handleError(failure),
      (anos) {
        _anos = anos;
        _veiculo = null;
      },
    );

    notifyListeners();
  }

  Future<void> fetchVeiculo(
      String marcaCodigo, String modeloCodigo, String anoCodigo) async {
    final result =
        await getVeiculo(_tipoVeiculo, marcaCodigo, modeloCodigo, anoCodigo);
    result.fold(
      (failure) => _handleError(failure),
      (veiculo) {
        _veiculo = veiculo;
      },
    );
  }

  ValueNotifier<bool> isFormComplete = ValueNotifier(false);

  void validateFormComplete() {
    isFormComplete.value = selectedMarca != null &&
        selectedModelo != null &&
        selectedAnoNotifier.value != null;
    notifyListeners();
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
