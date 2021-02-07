import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageBloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    return Scaffold(
        body: BlocListener<MyPageBloc, MyPageState>(
      listener: (context, state) {
        if (state is MyPageStart) {}
      },
      child: SafeArea(
        top: false,
        child: Container(
          color: buttonDisableColor,
          child: Column(
            children: <Widget>[
              SizedBox(height: 64),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 30),
                child: SvgPicture.asset("assets/icons/back_button.svg"),
              ),
              SizedBox(height: 36),
              Stack(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    height: 94,
                    child: PageView.builder(
                        controller:
                            BlocProvider.of<MyPageBloc>(context).pageController,
                        itemCount: _prompt.length,
                        onPageChanged: (page) {
                          BlocProvider.of<MyPageBloc>(context)
                              .add(MyPageSlide(page));
                        },
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                child: Image.asset(
                                    'assets/images/mypage_illust.png',
                                    height: 94),
                              ),
                              Expanded(child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    _prompt[index][0],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(22),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'nanum_square'),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _prompt[index][1],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(22),
                                        fontWeight: FontWeight.w800,
                                        fontFamily: 'nanum_square'),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    _prompt[index][2],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize:
                                            getProportionateScreenHeight(12),
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'nanum_square'),
                                  ),
                                ],
                              ),
                            ],
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        for (int i = 0; i < _prompt.length; i++)
                          if (i == 1) ...[_circleBar(true)] else
                            _circleBar(false),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(168),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0))),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 3),
      height: getProportionateScreenHeight(4),
      width: isActive
          ? getProportionateScreenWidth(14)
          : getProportionateScreenWidth(4),
      decoration: BoxDecoration(
          color: isActive ? primaryColor : textDisableColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  List<List<String>> _prompt = [
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ],
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ],
    [
      '최대 10글자로 타이틀',
      '총 2줄로 어때요?',
      '클릭해서 확인해보세요-!',
    ]
  ];
}
