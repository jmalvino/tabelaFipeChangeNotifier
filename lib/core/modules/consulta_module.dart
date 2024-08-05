import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabela_fipe_changenotifier/core/services/fipe_services.dart';
import 'package:tabela_fipe_changenotifier/data/datasources/fipe_datasource.dart';
import 'package:tabela_fipe_changenotifier/data/repositories/fipe_repository_impl.dart';
import 'package:tabela_fipe_changenotifier/domain/repositories/fipe_repository.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_anos.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_marcas.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_modelos.dart';
import 'package:tabela_fipe_changenotifier/domain/usecases/get_veiculo.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/consulta/consulta_page.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/consulta/consulta_state.dart';

class ConsultaModule extends Module {
  @override
  void binds(Injector i) {
    final List<void Function(Injector)> bindList = [
      (i) => i.addSingleton<FipeDataSource>(
            () => FipeDataSource(FipeService.client),
          ),
      (i) => i.addSingleton<FipeRepository>(
            () => FipeRepositoryImpl(i.get()),
          ),
      (i) => i.addSingleton<GetAnos>(
            () => GetAnos(
              i.get<FipeRepository>(),
            ),
          ),
      (i) => i.addSingleton<GetMarcas>(
            () => GetMarcas(
              i.get<FipeRepository>(),
            ),
          ),
      (i) => i.addSingleton<GetModelos>(
            () => GetModelos(
              i.get<FipeRepository>(),
            ),
          ),
      (i) => i.addSingleton<GetVeiculo>(
            () => GetVeiculo(
              i.get<FipeRepository>(),
            ),
          ),
      (i) => i.addSingleton<ConsultaState>(
            () => ConsultaState(
              getMarcas: i.get(),
              getModelos: i.get(),
              getAnos: i.get(),
              getVeiculo: i.get(),
              tipoVeiculo: i.args.data['type'],
            ),
            config: BindConfig(
              onDispose: (bloc) => bloc.dispose(),
            ),
          ),
    ];

    for (var bind in bindList) {
      bind(i);
    }
  }

  @override
  void routes(RouteManager r) {
    super.routes(r);
    r.child('/', child: (context) => const ConsultaPage());
  }

  // @override
  // List<ModularRoute> get routesTeste => [
  //   ChildRoute(
  //     Modular.initialRoute, // Rota inicial
  //     child: (context) => const ConsultaPage(), // Função corrigida
  //   ),
  // ];

}
