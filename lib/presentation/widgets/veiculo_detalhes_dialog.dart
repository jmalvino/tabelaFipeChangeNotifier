import 'package:flutter/material.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/veiculo.dart';

class VehicleDetailsDialog extends StatelessWidget {
  final Veiculo veiculo;

  const VehicleDetailsDialog({Key? key, required this.veiculo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Marca: ${veiculo.marca}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('Modelo: ${veiculo.modelo}'),
            const SizedBox(height: 8.0),
            Text('Ano: ${veiculo.anoModelo}'),
            const SizedBox(height: 8.0),
            Text('Combustível: ${veiculo.combustivel}'),
            const SizedBox(height: 8.0),
            Text('Valor: ${veiculo.valor}'),
            const SizedBox(height: 8.0),
            Text('Mês de Referência: ${veiculo.mesReferencia}'),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fechar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
