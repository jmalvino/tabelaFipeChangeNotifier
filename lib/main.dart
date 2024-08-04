import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabela_fipe_changenotifier/core/services/fipe_services.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_anos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_marcas.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_modelos.dart';
import 'package:tabela_fipe_changenotifier/domin/usecases/get_veiculo.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/change_notifier/fipe_change_notifier.dart';
import 'data/repositories/fipe_repository_impl.dart';
import 'data/datasources/fipe_datasource.dart';

void main() {
  final fipeDataSource = FipeDataSource(FipeService.client);
  final fipeRepository = FipeRepositoryImpl(fipeDataSource);
  final getMarcas = GetMarcas(fipeRepository);
  final getModelos = GetModelos(fipeRepository);
  final getAnos = GetAnos(fipeRepository);
  final getVeiculo = GetVeiculo(fipeRepository);

  runApp(
    ChangeNotifierProvider(
      create: (context) => FipeChangeNotifier(
        getMarcas: getMarcas,
        getModelos: getModelos,
        getAnos: getAnos,
        getVeiculo: getVeiculo,
      ),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Consulta FIPE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
