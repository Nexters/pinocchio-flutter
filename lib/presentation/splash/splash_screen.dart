import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/main/main_screen.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_bloc.dart';

import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is UserTokenCheckedSuccess) {
            Navigator.pushReplacement(context, MainScreen.route());
          } else if (state is UserTokenCheckedFailure) {
            // TODO 로그인 화면으로 전환
          }
        },
        child: Container(
          child: Center(
            child: Text('스플래쉬 화면 입니다.'),
          ),
        ),
      ),
    );
  }
}
