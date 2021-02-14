import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/utils/size_config.dart';

import 'bloc/photo_analysis_final_result_bloc.dart';
import 'bloc/photo_analysis_final_result_event.dart';

class PhotoAnalysisFinalResultScreen extends StatefulWidget {
  final String imagePath;

  const PhotoAnalysisFinalResultScreen({Key key, this.imagePath})
      : super(key: key);

  static Route route(String eventId, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisFinalResultBloc>(
        create: (context) {
          return PhotoAnalysisFinalResultBloc()
            ..add(PhotoAnalysisFinalResultInitialized(eventId));
        },
        child: PhotoAnalysisFinalResultScreen(
          imagePath: imagePath,
        ),
      ),
    );
  }

  @override
  _PhotoAnalysisFinalResultScreenState createState() =>
      _PhotoAnalysisFinalResultScreenState();
}

class _PhotoAnalysisFinalResultScreenState
    extends State<PhotoAnalysisFinalResultScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF1EFEE),
      body: SafeArea(
        top: false,
        child: Container(),
      ),
    );
  }
}
