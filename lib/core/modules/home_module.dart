import 'package:flutter_modular/flutter_modular.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/home/home_page.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const HomePage());
  }
}
