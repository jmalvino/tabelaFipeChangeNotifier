import 'package:flutter/material.dart';

// Esta classe gerencia o estado da tela inicial HomePage
class HomeState extends ChangeNotifier {
  String? _selectedVehicleType;

  // Retorna o tipo de veículo selecionado
  String? get selectedVehicleType => _selectedVehicleType;

  // Atualiza o tipo de veículo selecionado e notifica ouvintes
  void selectVehicleType(String vehicleType) {
    _selectedVehicleType = vehicleType;
    notifyListeners();
  }

  // Limpa a seleção de veículo (útil para redefinir o estado da página)
  void clearSelection() {
    _selectedVehicleType = null;
    notifyListeners();
  }
}
