import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text(
          'Consulta FIPE',
          style: TextStyle(color: Colors.grey[600]),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(
                  'lib/src/img/img_veiculos.png',
                  fit: BoxFit.contain,
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Modular.to.pushNamed('/home/consulta', arguments: {
                  'type': 'carros',
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(15),
                    ), // Define o raio dos cantos
                  ),
                ),
                child: Text(
                  'Carros',
                  style: TextStyle(
                    color: Colors.deepPurple[100],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Modular.to.pushNamed('/home/consulta', arguments: {
                  'type': 'motos',
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ), // Define o raio dos cantos
                  ),
                ),
                child: Text(
                  'Motos',
                  style: TextStyle(
                    color: Colors.deepPurple[100],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () =>
                    Modular.to.pushNamed('/home/consulta', arguments: {
                  'type': 'caminhoes',
                }),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(0),
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ), // Define o raio dos cantos
                  ),
                ),
                child: Text(
                  'Caminhões',
                  style: TextStyle(
                    color: Colors.deepPurple[100],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Escolha o tipo de veículo!",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
