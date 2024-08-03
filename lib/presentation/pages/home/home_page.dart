import 'package:flutter/material.dart';
import '../consulta/consulta_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consulta FIPE'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultaPage(tipoVeiculo: 'carros'),
                ),
              ),
              child: const Text('Carros'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultaPage(tipoVeiculo: 'motos'),
                ),
              ),
              child: const Text('Motos'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConsultaPage(tipoVeiculo: 'caminhoes'),
                ),
              ),
              child: const Text('Caminhões'),
            ),
          ],
        ),
      ),
    );
  }
}
