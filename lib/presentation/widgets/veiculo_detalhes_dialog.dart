import 'package:flutter/material.dart';
import 'package:tabela_fipe_changenotifier/domin/entities/veiculo.dart';

class VehicleDetailsDialog extends StatelessWidget {
  final Veiculo veiculo;

  const VehicleDetailsDialog({Key? key, required this.veiculo})
      : super(key: key);

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
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    textFormat('Marca:', veiculo.marca),
                    textFormat('Modelo:', veiculo.modelo),
                    textFormat('Ano:', '${veiculo.anoModelo}'),
                    textFormat('Combustível:', veiculo.combustivel),
                    textFormat('Valor:', veiculo.valor),
                    textFormat('Mês de Referência:', veiculo.mesReferencia),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ),
                  ],
                )
              : Column(
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
                            textFormat('Marca:', veiculo.marca),
                            textFormat('Modelo:', veiculo.modelo),
                            textFormat('Ano:', '${veiculo.anoModelo}'),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            textFormat('Combustível:', veiculo.combustivel),
                            textFormat('Valor:', veiculo.valor),
                            textFormat(
                                'Mês de Referência:', veiculo.mesReferencia),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget textFormat(String text, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              color: Colors.deepPurple[100],
            ),
          ),
          Text(
            valor,
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
