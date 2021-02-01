import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageBloc.dart';
import 'package:flutter_sancle/utils/constants.dart';

import 'bloc/MyPageEvent.dart';

class MyPageScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<MyPageBloc>(
          create: (context) {
            return MyPageBloc()..add(MyPageInitial());
          },
          child: MyPageScreen(),
        ));
  }

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: buttonDisableColor,
    );
  }
}
