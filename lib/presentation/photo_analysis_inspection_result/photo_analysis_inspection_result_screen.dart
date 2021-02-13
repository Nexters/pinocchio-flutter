import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/bloc/photo_analysis_inspection_result_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/bloc/photo_analysis_inspection_result_state.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bloc/photo_analysis_inspection_result_event.dart';

class PhotoAnalysisInspectionResultScreen extends StatefulWidget {
  final String imagePath;

  const PhotoAnalysisInspectionResultScreen({Key key, this.imagePath})
      : super(key: key);

  static Route route(CaptureEventResponse response, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisInspectionResultBloc>(
        create: (context) {
          return PhotoAnalysisInspectionResultBloc()
            ..add(PhotoAnalysisInspectionInitialized(response));
        },
        child: PhotoAnalysisInspectionResultScreen(
          imagePath: imagePath,
        ),
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
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF1EFEE),
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: BlocConsumer<PhotoAnalysisInspectionResultBloc,
            PhotoAnalysisInspectionResultState>(
          builder: (context, state) {
            return state is DataConversionFromSuccess
                ? _buildBody(state.response)
                : _buildLoading();
          },
          listener: (context, state) {
            if (state is DataConversionFromFailure) {
              Fluttertoast.showToast(msg: DEFAULT_ERROR_MSG);
              _closeScreen();
            }
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: getProportionateScreenWidth(21)),
            child: GestureDetector(
              onTap: () => _closeScreen(),
              child: SvgPicture.asset(
                'assets/icons/ic_close_middle.svg',
                width: getProportionateScreenWidth(34),
                height: getProportionateScreenWidth(34),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(30)),
            child: Text(
              '다음',
              style: TextStyle(
                fontSize: 16.0,
                color: sancleDarkColor,
                fontWeight: FontWeight.w700,
                fontFamily: 'nanum_square',
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF1EFEE),
    );
  }

  Widget _buildBody(CaptureEventResultResponse response) {
    return SingleChildScrollView(
      child: Column(),
    );
  }

  void _closeScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primaryColor)),
    );
  }
}
