import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/network/exception_handler.dart';
import 'package:flutter_sancle/data/repository/camera_result_repository.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_bloc.dart';
import 'package:flutter_sancle/presentation/home/home_screen.dart';
import 'package:flutter_sancle/presentation/photo_analysis/photo_analysis_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'bloc/camera_result_event.dart';
import 'bloc/camera_result_state.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CameraResultScreen extends StatefulWidget {
  final String path;
  final String category;

  const CameraResultScreen({Key key, this.path, this.category})
      : super(key: key);

  static Route route(String path, String category) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<CameraResultBloc>(
        create: (context) {
          return CameraResultBloc(CameraResultRepository());
        },
        child: CameraResultScreen(path: path, category: category),
      ),
    );
  }

  @override
  _CameraResultScreenState createState() => _CameraResultScreenState();
}

class _CameraResultScreenState extends State<CameraResultScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: BlocConsumer<CameraResultBloc, CameraResultState>(
          listener: (context, state) {
            if (state is PhotoDataRequestFailure) {
              if (state.dioError.response?.statusCode != 401) {
                Fluttertoast.showToast(msg: '잠시 후 다시 시도해주세요.');
                Navigator.popUntil(context,
                    (route) => route.settings.name == HomeScreen.routeName);
                return;
              }
              ExceptionHandler.handleException(context, state.dioError,
                  showsErrorMsg: false);
            } else if (state is PhotoDataRequestSuccess) {
              Navigator.pushAndRemoveUntil(context,
                  PhotoAnalysisScreen.route(state.response, widget.path),
                  (Route<dynamic> route) {
                return route.settings.name == HomeScreen.routeName;
              });
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Image.file(File(widget.path)),
                _buildBackBtn(),
                _buildBottomLayout(),
                state is PhotoDataRequestLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor),
                        ),
                      )
                    : Container()
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildBackBtn() {
    return Positioned(
      top: getProportionateScreenHeight(48),
      left: getProportionateScreenWidth(24),
      child: TouchableOpacity(
        activeOpacity: 0.6,
        onTap: () => _closeScreen(),
        child: SvgPicture.asset(
          'assets/icons/ic_back_normal.svg',
          height: getProportionateScreenHeight(32),
          width: getProportionateScreenHeight(32),
        ),
      ),
    );
  }

  Widget _buildBottomLayout() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        alignment: Alignment.topCenter,
        color: Colors.white,
        height: 145,
        width: double.infinity,
        child: _buildStartAnalysisBtn(),
      ),
    );
  }

  Widget _buildStartAnalysisBtn() {
    return TouchableOpacity(
      activeOpacity: 0.6,
      onTap: () {
        BlocProvider.of<CameraResultBloc>(context)
            .add(PhotoDataRequested(widget.category, widget.path));
      },
      child: Container(
        margin: EdgeInsets.only(top: getProportionateScreenHeight(65)),
        width: getProportionateScreenWidth(210),
        height: 52,
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Color(0x660F1012)),
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                '사진분석 시작하기',
                style: TextStyle(
                  color: sancleDarkColor,
                  fontSize: 16.0,
                  fontFamily: 'nanum_square',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: getProportionateScreenWidth(10)),
              alignment: Alignment.centerRight,
              child: SvgPicture.asset("assets/icons/ic_next_guide.svg"),
            )
          ],
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
