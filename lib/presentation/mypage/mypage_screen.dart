import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/presentation/category/category_screen.dart';
import 'package:flutter_sancle/presentation/home/home_screen.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageBloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import 'bloc/MyPageEvent.dart';

class MyPageScreen extends StatefulWidget {
  final MyPageResponse clothInfo;
  final HomeResponse profile;

  const MyPageScreen({this.clothInfo, this.profile}) : super();

  static Route route(MyPageResponse event, HomeResponse noti) {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<MyPageBloc>(
              create: (context) {
                return MyPageBloc()..add(MyPageInitial());
              },
              child: MyPageScreen(clothInfo: event, profile: noti),
            ));
  }

  @override
  _MyPageScreenState createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  List<SvgPicture> _currentCameraSvg = new List(5);
  GlobalKey clothNum = GlobalKey();
  double _width = 0.0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
      _currentCameraSvg[i] = new SvgPicture.asset(_category[i][0],
          height: getProportionateScreenHeight(60),
          width: getProportionateScreenWidth(60));
    }
    clothNum = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _width = clothNum.currentContext.size.width;
    });
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _width = clothNum.currentContext.size.width;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: buttonDisableColor,
        body: BlocListener<MyPageBloc, MyPageState>(
      listener: (context, state) {
        if (state is MyPageStart) {}
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: buttonDisableColor,
            child: Column(
              children: <Widget>[
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
                      height: getProportionateScreenHeight(56),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                          left: getProportionateScreenWidth(30)),
                      child: SvgPicture.asset("assets/icons/back_button.svg")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                _notice(),
                _profile(),
                SizedBox(
                  height: getProportionateScreenHeight(18),
                ),
                _cloth(),
                SizedBox(height: getProportionateScreenHeight(18)),
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
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
                  onTap: () {},
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
                  onTap: () {},
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
                  onTap: () {},
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

  Widget _notice(){
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: getProportionateScreenHeight(128),
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
                      alignment: Alignment.center,
                      child: Image.asset(
                          'assets/images/mypage_illust.png',
                          height: getProportionateScreenHeight(94)),
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: getProportionateScreenWidth(220),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              height:
                              getProportionateScreenHeight(36.0)),
                          Text(
                            widget.clothInfo.noticeViewList[index].title == null ? '' : widget.clothInfo.noticeViewList[index].title,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize:
                                getProportionateScreenHeight(
                                    22),
                                fontWeight: FontWeight.w800,
                                fontFamily: 'nanum_square'),
                          ),
                          // SizedBox(
                          //     height:
                          //     getProportionateScreenHeight(8.0)),
                          // Text(
                          //   widget.clothInfo.noticeViewList[index].description == null ? '' : widget.clothInfo.noticeViewList[index].description,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: TextStyle(
                          //       fontSize:
                          //       getProportionateScreenHeight(
                          //           22.0),
                          //       fontWeight: FontWeight.w800,
                          //       fontFamily: 'nanum_square'),
                          // ),
                          SizedBox(
                              height:
                              getProportionateScreenHeight(10.0)),
                          Text(
                            widget.clothInfo.noticeViewList[index].content == null ? '' : widget.clothInfo.noticeViewList[index].content,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize:
                                getProportionateScreenHeight(
                                    12.0),
                                fontWeight: FontWeight.w400,
                                fontFamily: 'nanum_square'),
                          ),
                        ],
                      ),
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
                    right: getProportionateScreenWidth(30.0),
                top: getProportionateScreenHeight(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    for (int i = 0; i < widget.clothInfo.noticeViewList.length; i++)
                      if (i == snapshot.data) ...[
                        _circleBar(true)
                      ] else
                        _circleBar(false),
                  ],
                ),
              );
            }),
      ],
    );
  }

  Widget _profile(){
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenHeight(30),
      ),
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
                '${widget.profile.nickName}님',
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
              Row(
                children: [
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: getProportionateScreenHeight(10)),
                      color: highlightColor,
                      height: getProportionateScreenHeight(4),
                      width: _width,
                    ),
                    Text(
                      '${widget.clothInfo.myLabelCount}',
                      key: clothNum,
                      style: TextStyle(
                          fontSize:
                          getProportionateScreenHeight(14),
                          fontWeight: FontWeight.w700,
                          fontFamily: 'nanum_square'),
                    ),
                  ]),
                  Text(
                    '벌!',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(14),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'nanum_square'),
                  )
                ],
              ),
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
    );
  }

  Widget _clothCategory(int index) {
    return Container(
      child: Column(
        children: [
          Container(
            child: GestureDetector(
              onTapCancel: () {
                setState(() {
                  _currentCameraSvg[index] = SvgPicture.asset(
                      _category[index][0],
                      height: getProportionateScreenHeight(60),
                      width: getProportionateScreenWidth(60));
                });
              },
              onTapDown: (_) {
                setState(() {
                  _currentCameraSvg[index] = SvgPicture.asset(
                      _category[index][1],
                      height: getProportionateScreenHeight(60),
                      width: getProportionateScreenWidth(60));
                });
              },
              onTapUp: (_) {
                setState(() {
                  _currentCameraSvg[index] = SvgPicture.asset(
                      _category[index][0],
                      height: getProportionateScreenHeight(60),
                      width: getProportionateScreenWidth(60));
                });
              },
              onTap: () {
                Navigator.push(context, CategoryScreen.route());
              },
              child: _currentCameraSvg[index],
            ),
          ),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          Text(_category[index][2],
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(14),
                  fontWeight: FontWeight.w400,
                  fontFamily: 'nanum_square')),
        ],
      ),
    );
  }

  Widget _cloth(){
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: getProportionateScreenHeight(30),
          horizontal: getProportionateScreenWidth(30)
      ),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                color: shadowColor,
                offset: Offset(1, 2),
                blurRadius: 2)
          ]),
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
            height: getProportionateScreenHeight(20),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(4, (index) {
                  return _clothCategory(index);
                }),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(1, (index) {
                  return _clothCategory(index+4);
                }),
              ),
            ],
          )
        ],
      ),
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

  double between() {
    double w = MediaQuery.of(context).size.width;
    return (w -
            getProportionateScreenWidth(30) * 2 -
            getProportionateScreenWidth(60) * 4) /
        3;
  }
}
