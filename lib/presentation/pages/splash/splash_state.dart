import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashState extends ChangeNotifier {
  SplashState() {
    _listinnerUser();
  }

  void _listinnerUser() async {
    await Future.delayed(
      const Duration(milliseconds: 5680),
    );
    Modular.to.navigate('/home');
  }
}
