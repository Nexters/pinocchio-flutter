import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc();
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
      body: Container(
        child: Center(
          child: Text('로그인 화면'),
        ),
      ),
    );
  }
}
