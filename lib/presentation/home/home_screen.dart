import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/repository/home_repository.dart';
import 'package:flutter_sancle/data/repository/mypage_repository.dart';
import 'package:flutter_sancle/presentation/camera/camera_screen.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_event.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_state.dart';
import 'package:flutter_sancle/presentation/mypage/mypage_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/home';
  final HomeResponse noti;

  const HomeScreen({this.noti}) : super();

  static Route route(HomeResponse event) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => BlocProvider<HomeBloc>(
        create: (context) {
          return HomeBloc(HomeRepository(), MyPageRepository())..add(HomeInitial());
        },
        child: HomeScreen(noti: event),
      ),
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = new PageController();
  int _currentPage = 0;
  SvgPicture currentCameraSvg;

  @override
  void initState() {
    super.initState();
    _initNotice();
    currentCameraSvg = SvgPicture.asset('assets/images/camera_unpressed.svg');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: whiteColor,
      body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is MypageStart) {
              BlocProvider.of<HomeBloc>(context).clothInfo.listen((event) {
                Navigator.push(context, MyPageScreen.route(event, widget.noti));
              });
            } else if (state is PermissionIsDenied) {
              _showPermissionDialog();
            } else if (state is PermissionIsGranted) {
              Navigator.push(context, CameraScreen.route());
            }
          },
          child: SafeArea(
            top: false,
            child: Stack(children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/home_background.png',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                  right: getProportionateScreenWidth(24),
                  top: getProportionateScreenHeight(58),
                  child: TouchableOpacity(
                    activeOpacity: 0.6,
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context).add(HomeToMypage());
                    },
                    child: SvgPicture.asset(
                      'assets/icons/my_page.svg',
                      width: getProportionateScreenHeight(52),
                      height: getProportionateScreenHeight(52),
                    ),
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(70),
                    left: getProportionateScreenWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text.rich(TextSpan(
                        text: widget.noti.nickName,
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(28),
                            fontWeight: FontWeight.w800,
                            fontFamily: 'nanum_square'),
                        children: <TextSpan>[
                          TextSpan(
                            text: '님,',
                            style: TextStyle(
                                fontSize: getProportionateScreenHeight(28),
                                fontWeight: FontWeight.w300,
                                fontFamily: 'nanum_square'),
                          )
                        ])),
                    SizedBox(height: getProportionateScreenHeight(12)),
                    Text(
                      '안녕하세요!',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(28),
                          fontWeight: FontWeight.w300,
                          fontFamily: 'nanum_square'),
                    ),
                    SizedBox(height: getProportionateScreenHeight(32)),
                    Text(
                      '현재 산타클로즈에 쌓인 옷',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'nanum_square'),
                    ),
                    SizedBox(height: getProportionateScreenHeight(8)),
                    Text(
                      '${widget.noti.globalCount}벌!',
                      style: TextStyle(
                          fontSize: getProportionateScreenHeight(16),
                          fontWeight: FontWeight.w800,
                          fontFamily: 'nanum_square'),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: SizeConfig.screenWidth,
                  height: getProportionateScreenHeight(168),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: getProportionateScreenHeight(17),
                            left: getProportionateScreenWidth(24)),
                        child: Row(
                          children: <Widget>[
                            for (int i = 0; i < _prompt.length; i++)
                              if (i == _currentPage) ...[_circleBar(true)] else
                                _circleBar(false),
                          ],
                        ),
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: controller,
                            // BlocProvider.of<HomeBloc>(context).pageController,
                            itemCount: _prompt.length,
                            onPageChanged: (page) {
                              // BlocProvider.of<HomeBloc>(context)
                              //     .add(HomePageSlide(page));
                              controller.jumpToPage(page);
                              setState(() {
                                _currentPage = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(24),
                                        right: getProportionateScreenWidth(24),
                                        top: getProportionateScreenHeight(18)),
                                    child: Text(
                                      widget.noti.notices[index].title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(22),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(24),
                                        right: getProportionateScreenWidth(24),
                                        top: getProportionateScreenHeight(10)),
                                    child: Text(
                                      widget.noti.notices[index].description,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: getProportionateScreenWidth(24),
                                        right: getProportionateScreenWidth(24),
                                        top: getProportionateScreenHeight(12)),
                                    child: Text(
                                      widget.noti.notices[index].content == null
                                          ? ''
                                          : widget.noti.notices[index].content,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(14),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: getProportionateScreenWidth(19),
                bottom: getProportionateScreenHeight(127),
                width: getProportionateScreenHeight(86),
                height: getProportionateScreenHeight(86),
                child: GestureDetector(
                    onTapCancel: () {
                      setState(() {
                        currentCameraSvg = SvgPicture.asset(
                            'assets/images/camera_unpressed.svg');
                      });
                    },
                    onTapDown: (_) {
                      setState(() {
                        currentCameraSvg = SvgPicture.asset(
                            'assets/images/camera_pressed.svg');
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        currentCameraSvg = SvgPicture.asset(
                            'assets/images/camera_unpressed.svg');
                      });
                    },
                    onTap: () {
                      BlocProvider.of<HomeBloc>(context)
                          .add(PermissionRequested());
                    },
                    child: currentCameraSvg),
              ),
            ]),
          )),
    );
  }

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: getProportionateScreenHeight(4),
      width: isActive
          ? getProportionateScreenWidth(14)
          : getProportionateScreenWidth(4),
      decoration: BoxDecoration(
          color: isActive ? primaryColor : textDisableColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }

  Future<void> _initNotice() async {
    await BlocProvider.of<HomeBloc>(context).add(GetNotice());
  }

  void promptInit() {}

  List<List<String>> _prompt = [
    [
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8',
      '라벨을 10개 찍으면 상품이 팡!',
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8'
    ],
    [
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8',
      '라벨을 10개 찍으면 상품이 팡!',
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8'
    ],
    [
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8',
      '라벨을 10개 찍으면 상품이 팡!',
      '산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8'
    ]
  ];

  _showPermissionDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('카메라에 대한 엑세스 권한이 없어요.'),
          content: Text('앱 설정으로 가서 엑세스 권한을 수정 할 수 있어요. 이동하시겠어요?'),
          actions: [
            CupertinoDialogAction(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('설정하기'),
              isDefaultAction: true,
              onPressed: () {
                openAppSettings();
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
