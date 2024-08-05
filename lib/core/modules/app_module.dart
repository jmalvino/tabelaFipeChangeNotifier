import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabela_fipe_changenotifier/core/modules/home_module.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/splash/splash_page.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/splash/splash_state.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<SplashState>(
      () => SplashState(),
      config: BindConfig(
        onDispose: (bloc) => bloc.dispose(),
      ),
    );
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const SplashPage());
    r.module('/home', module: HomeModule());
  }
}
