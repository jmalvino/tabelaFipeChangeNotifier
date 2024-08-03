import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabela_fipe_changenotifier/presentation/widgets/veiculo_detalhes_dialog.dart';
import '../../change_notifier/fipe_change_notifier.dart';

class ConsultaPage extends StatefulWidget {
  final String tipoVeiculo;
  const ConsultaPage({Key? key, required this.tipoVeiculo}) : super(key: key);

  @override
  _ConsultaPageState createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  String? _selectedMarca;
  String? _selectedModelo;
  String? _selectedAno;

  @override
  void initState() {
    super.initState();
    final fipeNotifier = Provider.of<FipeChangeNotifier>(context, listen: false);
    fipeNotifier.changeVehicleType(widget.tipoVeiculo);
  }

  @override
  Widget build(BuildContext context) {
    final fipeNotifier = Provider.of<FipeChangeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta FIPE: ${widget.tipoVeiculo.toUpperCase()}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedMarca,
              hint: const Text('Selecione a Marca'),
              isExpanded: true,
              items: fipeNotifier.marcas.map((marca) {
                return DropdownMenuItem<String>(
                  value: marca.codigo,
                  child: Text(marca.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedMarca = value;
                  _selectedModelo = null;
                  _selectedAno = null;
                });
                fipeNotifier.fetchModelos(value!);
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedModelo,
              hint: const Text('Selecione o Modelo'),
              isExpanded: true,
              items: fipeNotifier.modelos.map((modelo) {
                return DropdownMenuItem<String>(
                  value: modelo.codigo,
                  child: Text(modelo.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedModelo = value;
                  _selectedAno = null;
                });
                fipeNotifier.fetchAnos(_selectedMarca!, value!);
              },
            ),
            const SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedAno,
              hint: const Text('Selecione o Ano'),
              isExpanded: true,
              items: fipeNotifier.anos.map((ano) {
                return DropdownMenuItem<String>(
                  value: ano.codigo,
                  child: Text(ano.nome),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAno = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _selectedMarca != null && _selectedModelo != null && _selectedAno != null
                  ? () async {
                await fipeNotifier.fetchVeiculo(_selectedMarca!, _selectedModelo!, _selectedAno!);
                if (fipeNotifier.veiculo != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return VehicleDetailsDialog(
                        veiculo: fipeNotifier.veiculo!,
                      );
                    },
                  );
                }
              }
                  : null,
              child: const Text('Consultar'),
            ),
            if (fipeNotifier.errorMessage != null) ...[
              const SizedBox(height: 16.0),
              Text(
                fipeNotifier.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
