import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/app/bloc/auth_bloc.dart';
import 'package:flutter_sancle/presentation/app/bloc/auth_event.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ExceptionHandler {
  static handleException(BuildContext context, DioError error,
      {bool showsErrorMsg = true, String errorMsg = '잠시 후 다시 시도해주세요.'}) {
    if (error.response?.statusCode == 401) {
      BlocProvider.of<AuthBloc>(context).add(LogoutRequested(context));
    } else {
      if (showsErrorMsg) {
        Fluttertoast.showToast(msg: errorMsg);
      }
    }
  }
}
