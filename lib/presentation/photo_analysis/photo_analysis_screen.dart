import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_event.dart';
import 'package:flutter_sancle/presentation/photo_analysis/bloc/photo_analysis_state.dart';
import 'package:lottie/lottie.dart';

class PhotoAnalysisScreen extends StatefulWidget {
  static Route route(String eventId) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisBloc>(
        create: (context) {
          return PhotoAnalysisBloc()..add(PhotoAnalysisInitialized(eventId));
        },
        child: PhotoAnalysisScreen(),
      ),
    );
  }

  @override
  _PhotoAnalysisScreenState createState() => _PhotoAnalysisScreenState();
}

class _PhotoAnalysisScreenState extends State<PhotoAnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Lottie.asset('assets/images/lottie_example.json'),
      ),
    );
  }
}
