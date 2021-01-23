import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_event.dart';
import 'package:flutter_sancle/presentation/main/main_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';

import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc()..add(KakaoTalkInstalled());
        },
        child: LoginScreen(),
      ),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushReplacement(context, MainScreen.route());
          } else if (state is UserLoginFailure) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(DEFAULT_ERROR_MSG)));
          }
        },
        child: Container(
          child: Center(
            child: RaisedButton(
              child: Text('카카오 로그인'),
              onPressed: () {
                BlocProvider.of<LoginBloc>(context)
                    .add(KakaoTalkLoginRequested());
              },
            ),
          ),
        ),
      ),
    );
  }
}
