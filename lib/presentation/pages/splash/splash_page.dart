import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:tabela_fipe_changenotifier/presentation/pages/splash/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashState splashState;

  @override
  void initState() {
    super.initState();
    splashState = Modular.get<SplashState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 20),
          child: SizedBox(
            width: 200,
            height: 200,
            child: Lottie.asset(
              'lib/src/img/car_const_g.json',
              repeat: false,
            ),
          ),
        ),
      ),
    );
  }
}
