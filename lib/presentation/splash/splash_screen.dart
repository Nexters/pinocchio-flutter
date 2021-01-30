import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/login/login_screen.dart';
import 'package:flutter_sancle/presentation/main/main_screen.dart';
import 'package:flutter_sancle/presentation/onboarding/onboarding_screen.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'bloc/splash_state.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is UserTokenCheckedSuccess) {
            Navigator.pushReplacement(context, OnboardingScreen.route());
          } else if (state is UserTokenCheckedFailure) {
            Navigator.pushReplacement(context, LoginScreen.route());
          }
        },
        child: Container(
          child: Center(
            child: Image.asset("assets/images/sancle_logo_full_yellow.png"),
          ),
        ),
      ),
    );
  }
}
