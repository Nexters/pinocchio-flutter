import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/camera_result_response.dart';
import 'package:flutter_sancle/data/network/exception_handler.dart';
import 'package:flutter_sancle/data/repository/photo_analysis_repository.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_state.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/photo_analysis_inspection_result_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PhotoAnalysisScreen extends StatefulWidget {
  final String imagePath;

  const PhotoAnalysisScreen({Key key, this.imagePath}) : super(key: key);

  static Route route(CameraResultResponse response, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisBloc>(
        create: (context) {
          return PhotoAnalysisBloc(PhotoAnalysisRepository())
            ..add(PhotoAnalysisInitialized(response));
        },
        child: PhotoAnalysisScreen(
          imagePath: imagePath,
        ),
      ),
    );
  }

  @override
  _PhotoAnalysisScreenState createState() => _PhotoAnalysisScreenState();
}

class _PhotoAnalysisScreenState extends State<PhotoAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PhotoAnalysisBloc, PhotoAnalysisState>(
      listener: (context, state) {
        if (state is PhotoAnalysisSuccess) {
          Navigator.pushReplacement(
              context,
              PhotoAnalysisInspectionResultScreen.route(
                  state.response, widget.imagePath));
        } else if (state is PhotoAnalysisFailure) {
          if (state.exception is DioError) {
            final dioError = state.exception as DioError;
            if (dioError.response?.statusCode == 401) {
              ExceptionHandler.handleException(context, dioError);
            } else {
              Fluttertoast.showToast(msg: DEFAULT_ERROR_MSG);
              _closeScreen();
            }
          } else {
            Fluttertoast.showToast(msg: DEFAULT_ERROR_MSG);
            _closeScreen();
          }
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Lottie.asset('assets/images/lottie_example.json'),
        ),
      ),
    );
  }

  void _closeScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
