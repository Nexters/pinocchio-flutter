import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:flutter_sancle/presentation/home/home_screen.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageBloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

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
  List<SvgPicture> _currentCameraSvg = new List(5);

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _currentCameraSvg[i] = new SvgPicture.asset(_category[i][0],
          height: getProportionateScreenHeight(60),
          width: getProportionateScreenWidth(60));
    }
    print('height 94 : ${getProportionateScreenHeight(94)}');
    print('height 20 : ${getProportionateScreenHeight(20)}');
    print('height 22 : ${getProportionateScreenHeight(22)}');
    print('height 8 : ${getProportionateScreenHeight(8)}');
    print('height 22 : ${getProportionateScreenHeight(22)}');
    print('height 10 : ${getProportionateScreenHeight(10)}');
    print('height 12 : ${getProportionateScreenHeight(12)}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<MyPageBloc, MyPageState>(
      listener: (context, state) {
        if (state is MyPageStart) {}
      },
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            color: buttonDisableColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: getProportionateScreenHeight(64)),
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(30)),
                      child: SvgPicture.asset("assets/icons/back_button.svg")),
                  onTap: () {
                    Navigator.pushReplacement(context, HomeScreen.route());
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(36)),
                Stack(
                  children: [
                    Container(
                      height: getProportionateScreenHeight(94),
                      child: PageView.builder(
                          controller: BlocProvider.of<MyPageBloc>(context)
                              .pageController,
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
                                  width: getProportionateScreenWidth(30),
                                ),
                                Container(
                                  child: Image.asset(
                                      'assets/images/mypage_illust.png',
                                      height: getProportionateScreenHeight(94)),
                                ),
                                Expanded(child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(20.0)),
                                    Container(
                                      height: getProportionateScreenHeight(22),
                                      child: Text(
                                        _prompt[index][0],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(22),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'nanum_square'),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(8.0)),
                                    Container(
                                      height: getProportionateScreenHeight(22),
                                      child: Text(
                                        _prompt[index][1],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    22.0),
                                            fontWeight: FontWeight.w800,
                                            fontFamily: 'nanum_square'),
                                      ),
                                    ),
                                    SizedBox(
                                        height:
                                            getProportionateScreenHeight(10.0)),
                                    Container(
                                      height: getProportionateScreenHeight(
                                          12.0),
                                      child: Text(
                                        _prompt[index][2],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize:
                                                getProportionateScreenHeight(
                                                    12.0),
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'nanum_square'),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: getProportionateScreenWidth(30))
                              ],
                            );
                          }),
                    ),
                    StreamBuilder<int>(
                        stream:
                            BlocProvider.of<MyPageBloc>(context).currentPage,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return Container(
                            padding: EdgeInsets.only(
                                right: getProportionateScreenWidth(30.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                for (int i = 0; i < _prompt.length; i++)
                                  if (i == snapshot.data) ...[
                                    _circleBar(true)
                                  ] else
                                    _circleBar(false),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                      right: getProportionateScreenWidth(30)),
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(126),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            offset: Offset(1, 2),
                            blurRadius: 2)
                      ]),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Container()),
                          Text(
                            '라벨라벨라벨라님',
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(20),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'nanum_square'),
                          ),
                          SizedBox(height: getProportionateScreenHeight(12)),
                          Text(
                            '산클 옷장에 쌓인 옷',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(14),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'nanum_square'),
                          ),
                          SizedBox(height: getProportionateScreenHeight(8)),
                          Text.rich(TextSpan(
                              text: '12345678912345',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'nanum_square'),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '벌!',
                                  style: TextStyle(
                                      fontSize:
                                          getProportionateScreenHeight(14),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'nanum_square'),
                                )
                              ])),
                          Expanded(child: Container()),
                        ],
                      ),
                      Expanded(child: Container()),
                      Image.asset(
                        'assets/images/default_profile.png',
                        height: getProportionateScreenHeight(78),
                        width: getProportionateScreenWidth(78),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: getProportionateScreenWidth(30),
                      top: getProportionateScreenHeight(30),
                      right: getProportionateScreenWidth(30)),
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(286),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor,
                            offset: Offset(1, 2),
                            blurRadius: 2)
                      ]),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '판별한 의류',
                          style: TextStyle(
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w800,
                              fontFamily: 'nanum_square'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 188,
                            child: LayoutGrid(
                              columnSizes: [getProportionateScreenWidth(60).px, getProportionateScreenWidth(60).px, getProportionateScreenWidth(60).px, getProportionateScreenWidth(60).px],
                              rowSizes: [getProportionateScreenHeight(86).px, getProportionateScreenHeight(86).px],
                              columnGap: between(),
                              rowGap: getProportionateScreenHeight(20),
                              children:
                                  List.generate(_category.length, (index) {
                                return Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: GestureDetector(
                                          onTapCancel: () {
                                            setState(() {
                                              _currentCameraSvg[index] =
                                                  SvgPicture.asset(
                                                      _category[index][0],
                                                      height:
                                                          getProportionateScreenHeight(
                                                              60),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              60));
                                            });
                                          },
                                          onTapDown: (_) {
                                            setState(() {
                                              _currentCameraSvg[index] =
                                                  SvgPicture.asset(
                                                      _category[index][1],
                                                      height:
                                                          getProportionateScreenHeight(
                                                              60),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              60));
                                            });
                                          },
                                          onTapUp: (_) {
                                            setState(() {
                                              _currentCameraSvg[index] =
                                                  SvgPicture.asset(
                                                      _category[index][0],
                                                      height:
                                                          getProportionateScreenHeight(
                                                              60),
                                                      width:
                                                          getProportionateScreenWidth(
                                                              60));
                                            });
                                          },
                                          onTap: () {},
                                          child: _currentCameraSvg[index],
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            getProportionateScreenHeight(10),
                                      ),
                                      Text(_category[index][2],
                                          style: TextStyle(
                                              fontSize:
                                                  getProportionateScreenHeight(
                                                      14),
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'nanum_square')),
                                    ],
                                  ),
                                );
                              }),
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(18)),
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child:                 Container(
                    height: getProportionateScreenHeight(62),
                    padding:
                    EdgeInsets.only(left: getProportionateScreenWidth(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('공지사항',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'nanum_square')),
                  ),
                  onTap: () {
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
                    height: getProportionateScreenHeight(62),
                    padding:
                    EdgeInsets.only(left: getProportionateScreenWidth(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('자주 묻는 질문',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'nanum_square')),
                  ),
                  onTap: () {
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(6)),
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
                    height: getProportionateScreenHeight(62),
                    padding:
                    EdgeInsets.only(left: getProportionateScreenWidth(30)),
                    alignment: Alignment.centerLeft,
                    child: Text('로그아웃',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'nanum_square')),
                  ),
                  onTap: () {
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(46)),
              ],
            ),
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

  List<List<String>> _category = [
    ['assets/icons/top.svg', 'assets/icons/top_press.svg', '상의'],
    ['assets/icons/pants.svg', 'assets/icons/pants_press.svg', '하의'],
    ['assets/icons/socks.svg', 'assets/icons/socks_press.svg', '양말'],
    ['assets/icons/underwear.svg', 'assets/icons/underwear_press.svg', '속옷'],
    ['assets/icons/towel.svg', 'assets/icons/towel_press.svg', '수건'],
  ];

  double between(){
    double w = MediaQuery.of(context).size.width;
    return (w - getProportionateScreenWidth(30) * 2 - getProportionateScreenWidth(60) *4)/3;
  }
}
