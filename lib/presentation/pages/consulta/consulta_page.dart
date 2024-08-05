import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/consulta/consulta_state.dart';
import 'package:tabela_fipe_changenotifier/presentation/widgets/custom_drop_down.dart';
import 'package:tabela_fipe_changenotifier/presentation/widgets/veiculo_detalhes_dialog.dart';

class ConsultaPage extends StatefulWidget {
  const ConsultaPage({super.key});

  @override
  _ConsultaPageState createState() => _ConsultaPageState();
}

class _ConsultaPageState extends State<ConsultaPage> {
  late ConsultaState consultaState;

  @override
  void initState() {
    super.initState();
    consultaState = Modular.get<ConsultaState>();
    consultaState.changeVehicleType(consultaState.tipoVeiculo);
  }

  void _showVehicleDetailsDialog(BuildContext context) {
    if (consultaState.veiculo != null) {
      showDialog(
        context: context,
        builder: (context) {
          return VehicleDetailsDialog(
            veiculo: consultaState.veiculo!,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.deepPurple[100],
        ),
        elevation: 0,
        backgroundColor: Colors.grey[900],
        title: Text(
          'Consulta FIPE: ${consultaState.tipoVeiculo.toUpperCase()}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: consultaState.isLoading,
        builder: (context, value, _) {
          if (value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomDropdown<String>(
                    value: consultaState.selectedMarca,
                    hint: 'Selecione a Marca',
                    isExpanded: true,
                    buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.deepPurple[100]!, width: 1),
                      ),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: consultaState.marcas.map((marca) {
                      return DropdownMenuItem<String>(
                        value: marca.codigo,
                        child: Text(
                          marca.nome,
                          style: TextStyle(
                            color: marca.codigo == consultaState.selectedMarca
                                ? Colors.deepPurple[200]
                                : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      consultaState.selectedMarca = value;
                      consultaState.fetchModelos(value!);
                    },
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      if (consultaState.selectedMarca == null) {
                        _showSnackbar(context, "Selecione primeiro a Marca");
                      }
                    },
                    child: CustomDropdown<String>(
                      value: consultaState.selectedModelo,
                      hint: 'Selecione o Modelo',
                      isExpanded: true,
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.deepPurple[100]!, width: 1),
                        ),
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: Colors.deepPurple[100]!, width: 1),
                        ),
                      ),
                      items: consultaState.modelos.map((modelo) {
                        return DropdownMenuItem<String>(
                          value: modelo.codigo,
                          child: Text(
                            modelo.nome,
                            style: TextStyle(
                              color:
                                  modelo.codigo == consultaState.selectedModelo
                                      ? Colors.deepPurple[200]
                                      : Colors.black,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        consultaState.setModelo = value;
                        consultaState.fetchAnos(
                            consultaState.selectedMarca!, value!);
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      if (consultaState.selectedMarca == null) {
                        _showSnackbar(context, "Selecione primeiro a Marca");
                      } else {
                        _showSnackbar(context, "Selecione o Modelo");
                      }
                    },
                    child: ValueListenableBuilder(
                      valueListenable: consultaState.selectedAnoNotifier,
                      builder: (context, value, _) {
                        return CustomDropdown<String>(
                          value: consultaState.selectAno,
                          hint: 'Selecione o Ano',
                          isExpanded: true,
                          buttonStyleData: ButtonStyleData(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.deepPurple[100]!, width: 1),
                            ),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.deepPurple[100]!, width: 1),
                            ),
                          ),
                          items: consultaState.anos.map((ano) {
                            return DropdownMenuItem<String>(
                              value: ano.codigo,
                              child: Text(
                                ano.nome,
                                style: TextStyle(
                                  color: ano.codigo ==
                                          consultaState
                                              .selectedAnoNotifier.value
                                      ? Colors.deepPurple[200]
                                      : Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            consultaState.selectedAno = value;
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  ValueListenableBuilder(
                      valueListenable: consultaState.isFormComplete,
                      builder: (context, value, _) {
                        if (!value) {
                          return const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              'Selecione todos os campos',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              onPressed: () {
                                consultaState
                                    .fetchVeiculo(
                                        consultaState.selectedMarca!,
                                        consultaState.selectedModelo!,
                                        consultaState
                                            .selectedAnoNotifier.value!)
                                    .then((_) {
                                  _showVehicleDetailsDialog(context);
                                });
                              },
                              child: const Text('Consultar'),
                            ),
                          );
                        }
                      }),
                  if (consultaState.errorMessage != null) ...[
                    const SizedBox(height: 16.0),
                    Text(
                      consultaState.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
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
