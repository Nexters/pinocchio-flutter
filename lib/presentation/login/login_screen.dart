import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/repository/login_repository.dart';
import 'package:flutter_sancle/presentation/login/bloc/login_event.dart';
import 'package:flutter_sancle/presentation/home/home_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<LoginBloc>(
        create: (context) {
          return LoginBloc(LoginRepository())..add(KakaoTalkInstalled());
        },
        child: LoginScreen(),
      ),
    );
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isIOS = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      isIOS = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is UserLoginSuccess) {
            Navigator.pushReplacement(context, HomeScreen.route());
          } else if (state is UserLoginFailure) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text(DEFAULT_ERROR_MSG)));
          }
        },
        builder: (context, state) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/login_background.png",
                fit: BoxFit.cover,
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(
                    top: getProportionateScreenHeight(72),
                    left: getProportionateScreenWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset("assets/images/sancle_logo_white.png"),
                    SizedBox(height: getProportionateScreenHeight(22)),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Text(
                        '간편하게 로그인하고\n서비스를 이용해 보세요',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: 'nanum_square',
                          color: sancleDarkColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildKakaoLoginButton(),
                  VerticalSpacing(of: 16.0),
                  _buildAppleLoginButton(),
                  isIOS ? VerticalSpacing(of: 62.0) : VerticalSpacing(of: 28.0),
                ],
              ),
              state is LoginLoading
                  ? Center(
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(primaryColor)))
                  : Container()
            ],
          );
        },
      ),
    );
  }

  Widget _buildKakaoLoginButton() {
    return TouchableOpacity(
      activeOpacity: 0.6,
      onTap: () {
        BlocProvider.of<LoginBloc>(context).add(KakaoTalkLoginRequested());
      },
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(52),
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(38)),
        decoration: BoxDecoration(
          color: kakaoLoginColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset("assets/icons/ic_kakao_logo.svg"),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '카카오톡으로 로그인',
                style: TextStyle(
                    color: sancleDarkColor,
                    fontSize: 14.0,
                    fontFamily: 'nanum_square',
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAppleLoginButton() {
    return TouchableOpacity(
      activeOpacity: 0.6,
      onTap: () {
        // TODO 애플 로그인 추후 작업
      },
      child: Container(
        width: double.infinity,
        height: getProportionateScreenHeight(52),
        margin:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(38)),
        decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset("assets/icons/ic_apple_logo.svg"),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'APPLE로 로그인',
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 14.0,
                    fontFamily: 'nanum_square',
                    fontWeight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
