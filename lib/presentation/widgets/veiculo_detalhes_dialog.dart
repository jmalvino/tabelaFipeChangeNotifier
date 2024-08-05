import 'package:flutter/material.dart';
import 'package:tabela_fipe_changenotifier/domain/entities/veiculo.dart';

class VehicleDetailsDialog extends StatelessWidget {
  final Veiculo veiculo;

  const VehicleDetailsDialog({super.key, required this.veiculo});

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Dialog(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: orientation == Orientation.portrait
              ? _buildPortraitContent(context)
              : _buildLandscapeContent(context),
        ),
      ),
    );
  }

  Widget _buildPortraitContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _textFormat('Marca:', veiculo.marca),
        _textFormat('Modelo:', veiculo.modelo),
        _textFormat('Ano:', '${veiculo.anoModelo}'),
        _textFormat('Combustível:', veiculo.combustivel),
        _textFormat('Valor:', veiculo.valor),
        _textFormat('Mês de Referência:', veiculo.mesReferencia),
        const SizedBox(height: 16.0),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _textFormat('Marca:', veiculo.marca),
                _textFormat('Modelo:', veiculo.modelo),
                _textFormat('Ano:', '${veiculo.anoModelo}'),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _textFormat('Combustível:', veiculo.combustivel),
                _textFormat('Valor:', veiculo.valor),
                _textFormat('Mês de Referência:', veiculo.mesReferencia),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fechar'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _textFormat(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.deepPurple[100],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}