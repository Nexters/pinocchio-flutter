import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/auth_repository.dart';
import 'package:flutter_sancle/presentation/main/main_screen.dart';

import 'bloc/auth_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          home: MainScreen(),
        ),
      ),
    );
  }
}
