import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';
import 'package:flutter_sancle/data/repository/onboarding_repository.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_bloc.dart';
import 'package:flutter_sancle/presentation/splash/bloc/splash_event.dart';
import 'package:flutter_sancle/presentation/splash/splash_screen.dart';

import 'bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return RepositoryProvider<AuthRepository>(
      create: (context) {
        return AuthRepository();
      },
      child: BlocProvider<AuthBloc>(
        create: (context) {
          final authRepository = RepositoryProvider.of<AuthRepository>(context);
          return AuthBloc(authRepository);
        },
        child: MaterialApp(
          home: BlocProvider<SplashBloc>(
            create: (context) {
              final authRepository =
                  RepositoryProvider.of<AuthRepository>(context);
              return SplashBloc(authRepository, OnboardingRepository())
                ..add(UserTokenChecked());
            },
            child: SplashScreen(),
          ),
        ),
      ),
    );
  }
}
