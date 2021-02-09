import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera_result/bloc/camera_result_bloc.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CameraResultScreen extends StatefulWidget {
  final String path;
  final String category;

  const CameraResultScreen({Key key, this.path, this.category})
      : super(key: key);

  static Route route(String path, String category) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<CameraResultBloc>(
        create: (context) {
          return CameraResultBloc();
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
        child: Stack(
          children: [
            Image.file(File(widget.path)),
            _buildBackBtn(),
            _buildBottomLayout()
          ],
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
      onTap: () {},
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
