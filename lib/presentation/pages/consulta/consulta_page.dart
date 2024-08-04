import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabela_fipe_changenotifier/presentation/widgets/veiculo_detalhes_dialog.dart';
import '../../change_notifier/fipe_change_notifier.dart';

class ConsultaPage extends StatefulWidget {
  final String tipoVeiculo;

  const ConsultaPage({super.key, required this.tipoVeiculo});

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
    final fipeNotifier =
        Provider.of<FipeChangeNotifier>(context, listen: false);
    fipeNotifier.changeVehicleType(widget.tipoVeiculo);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fipeNotifier = Provider.of<FipeChangeNotifier>(context);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple[100],
        ),
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text(
          'Consulta FIPE: ${widget.tipoVeiculo.toUpperCase()}',
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton2<String>(
                value: _selectedMarca,
                hint: const Text(
                  'Selecione a Marca',
                  style: TextStyle(color: Colors.white),
                ),
                isExpanded: true,
                buttonStyleData: ButtonStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.deepPurple[100]!, width: 1),
                  ),
                ),
                dropdownStyleData: DropdownStyleData(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: fipeNotifier.marcas.map((marca) {
                  return DropdownMenuItem<String>(
                    value: marca.codigo,
                    child: Text(
                      marca.nome,
                      style: TextStyle(
                        color: marca.codigo == _selectedMarca
                            ? Colors.deepPurple[200]
                            : Colors.black,
                      ),
                    ),
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
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: (){
                  if(_selectedMarca == null){
                    _showSnackbar(context, "Selecione primeiro a Marca");
                  }
                },
                child: DropdownButton2<String>(
                  value: _selectedModelo,
                  style: const TextStyle(color: Colors.white),
                  hint: const Text(
                    'Selecione o Modelo',
                    style: TextStyle(color: Colors.white),
                  ),
                  isExpanded: true,
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple[100]!, width: 1),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple[100]!, width: 1),
                    ),
                  ),
                  items: fipeNotifier.modelos.map((modelo) {
                    return DropdownMenuItem<String>(
                      value: modelo.codigo,
                      child: Text(
                        modelo.nome,
                        style: TextStyle(
                          color: modelo.codigo == _selectedModelo
                              ? Colors.deepPurple[200]
                              : Colors.black,
                        ),
                      ),
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
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: (){
                  if(_selectedMarca == null){
                    _showSnackbar(context, "Selecione primeiro a Marca");
                  }else{
                    _showSnackbar(context, "Selecione o Modelo");
                  }
                },
                child: DropdownButton2<String>(
                  value: _selectedAno,
                  hint: const Text(
                    'Selecione o Ano',
                    style: TextStyle(color: Colors.white),
                  ),
                  isExpanded: true,
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple[100]!, width: 1),
                    ),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.deepPurple[100]!, width: 1),
                    ),
                  ),
                  items: fipeNotifier.anos.map((ano) {
                    return DropdownMenuItem<String>(
                      value: ano.codigo,
                      child: Text(
                        ano.nome,
                        style: TextStyle(
                          color: ano.codigo == _selectedAno
                              ? Colors.deepPurple[200]
                              : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedAno = value;
                    });
                  },
                ),
              ),
              Visibility(
                visible: _selectedAno == null,
                child: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    'Selecione todos os campos',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: _selectedMarca != null &&
                          _selectedModelo != null &&
                          _selectedAno != null
                      ? () async {
                          await fipeNotifier.fetchVeiculo(
                              _selectedMarca!, _selectedModelo!, _selectedAno!);
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
      ),
    );
  }

  void _showSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.deepPurple,
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
