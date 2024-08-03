import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/ano.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/marca.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/modelo.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/veiculo.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_anos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_marcas.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_modelos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_veiculo.dart';
import '../../../core/error/failure.dart';

// Gerencia o estado da tela de Consulta
class ConsultaState extends ChangeNotifier {
  final GetMarcas getMarcas;
  final GetModelos getModelos;
  final GetAnos getAnos;
  final GetVeiculo getVeiculo;

  String? _selectedMarca;
  String? _selectedModelo;
  String? _selectedAno;
  String _tipoVeiculo = 'carros';

  List<Marca> _marcas = [];
  List<Modelo> _modelos = [];
  List<Ano> _anos = [];
  Veiculo? _veiculo;
  String? _errorMessage;

  // Construtor
  ConsultaState({
    required this.getMarcas,
    required this.getModelos,
    required this.getAnos,
    required this.getVeiculo,
  });

  // Getters
  String? get selectedMarca => _selectedMarca;
  String? get selectedModelo => _selectedModelo;
  String? get selectedAno => _selectedAno;
  List<Marca> get marcas => _marcas;
  List<Modelo> get modelos => _modelos;
  List<Ano> get anos => _anos;
  Veiculo? get veiculo => _veiculo;
  String? get errorMessage => _errorMessage;

  // Atualiza o tipo de veículo selecionado
  void changeVehicleType(String tipo) {
    _tipoVeiculo = tipo;
    notifyListeners();
    fetchMarcas();
  }

  // Atualiza a marca selecionada
  void setSelectedMarca(String marcaCodigo) {
    _selectedMarca = marcaCodigo;
    _selectedModelo = null;
    _selectedAno = null;
    _modelos.clear();
    _anos.clear();
    notifyListeners();
    fetchModelos(marcaCodigo);
  }

  // Atualiza o modelo selecionado
  void setSelectedModelo(String modeloCodigo) {
    _selectedModelo = modeloCodigo;
    _selectedAno = null;
    _anos.clear();
    notifyListeners();
    fetchAnos(_selectedMarca!, modeloCodigo);
  }

  // Atualiza o ano selecionado
  void setSelectedAno(String anoCodigo) {
    _selectedAno = anoCodigo;
    notifyListeners();
  }

  // Busca as marcas na API
  Future<void> fetchMarcas() async {
    final result = await getMarcas(_tipoVeiculo);
    _handleResult<List<Marca>>(result, onSuccess: (marcas) {
      _marcas = marcas;
      notifyListeners();
    });
  }

  // Busca os modelos na API
  Future<void> fetchModelos(String marcaCodigo) async {
    final result = await getModelos(_tipoVeiculo, marcaCodigo);
    _handleResult<List<Modelo>>(result, onSuccess: (modelos) {
      _modelos = modelos;
      notifyListeners();
    });
  }

  // Busca os anos na API
  Future<void> fetchAnos(String marcaCodigo, String modeloCodigo) async {
    final result = await getAnos(_tipoVeiculo, marcaCodigo, modeloCodigo);
    _handleResult<List<Ano>>(result, onSuccess: (anos) {
      _anos = anos;
      notifyListeners();
    });
  }

  // Busca os detalhes do veículo na API
  Future<void> fetchVeiculo(String marcaCodigo, String modeloCodigo, String anoCodigo) async {
    final result = await getVeiculo(_tipoVeiculo, marcaCodigo, modeloCodigo, anoCodigo);
    _handleResult<Veiculo>(result, onSuccess: (veiculo) {
      _veiculo = veiculo;
      notifyListeners();
    });
  }

  // Tratamento de erros e atualização de estado
  void _handleResult<T>(Either<Failure, T> result, {required Function(T) onSuccess}) {
    result.fold(
          (failure) => _handleError(failure),
          (data) {
        _errorMessage = null;
        onSuccess(data);
      },
    );
  }

  // Tratamento de erros específicos
  void _handleError(Failure failure) {
    if (failure is ServerFailure) {
      _errorMessage = 'Erro ao acessar a API. Tente novamente.';
    } else {
      _errorMessage = 'Erro desconhecido.';
    }
    notifyListeners();
  }
}
