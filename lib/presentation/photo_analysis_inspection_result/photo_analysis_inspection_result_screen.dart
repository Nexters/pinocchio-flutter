import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/bloc/photo_analysis_inspection_result_bloc.dart';

class PhotoAnalysisInspectionResultScreen extends StatefulWidget {
  static Route route(CaptureEventResponse response, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisInspectionResultBloc>(
        create: (context) {
          return PhotoAnalysisInspectionResultBloc();
        },
        child: PhotoAnalysisInspectionResultScreen(),
      ),
    );
  }

  @override
  _PhotoAnalysisInspectionResultScreenState createState() =>
      _PhotoAnalysisInspectionResultScreenState();
}

class _PhotoAnalysisInspectionResultScreenState
    extends State<PhotoAnalysisInspectionResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
