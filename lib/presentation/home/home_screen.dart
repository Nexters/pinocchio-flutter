import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_event.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_state.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
        builder: (_) => BlocProvider<HomeBloc>(
              create: (context) {
                return HomeBloc()..add(HomeInitial());
              },
              child: HomeScreen(),
            ));
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {},
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
              right: MediaQuery.of(context).size.width * 0.0826,
              top: MediaQuery.of(context).size.height * 0.079,
              child: Image.asset(
                'assets/icons/mypage.png',
                width: 38,
                height: 44,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(70),
                  left: getProportionateScreenWidth(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(
                      text: '라벨라벨라벨라벨',
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
                  SizedBox(height: 12),
                  Text(
                    '안녕하세요!',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(30),
                        fontWeight: FontWeight.w300,
                        fontFamily: 'nanum_square'),
                  ),
                  SizedBox(height: 32),
                  Text(
                    '현재 산타클로즈에 쌓인 옷',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w400,
                        fontFamily: 'nanum_square'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '100,000벌!',
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.216, // 168
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      StreamBuilder<int>(
                        stream: BlocProvider.of<HomeBloc>(context).currentPage,
                        builder: (context, snapshot) {
                          return Container(
                            padding: EdgeInsets.only(top: 17, left: 24),
                            child: Row(
                              children: <Widget>[
                                for (int i = 0; i < _prompt.length; i++)
                                  if (i == snapshot.data) ...[_circleBar(true)] else
                                    _circleBar(false),
                              ],
                            ),
                          );
                        }
                      ),
                      Expanded(
                        child: PageView.builder(
                            controller: BlocProvider.of<HomeBloc>(context).pageController,
                            itemCount: _prompt.length,
                            onPageChanged: (page) {
                              BlocProvider.of<HomeBloc>(context).add(HomePageSlide(page));
                            },
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 24, right: 59, top: 18),
                                    child: Text(
                                      _prompt[index][0],
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(22),
                                          fontWeight: FontWeight.w800,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 24, right: 59, top: 10),
                                    child: Text(
                                      _prompt[index][1],
                                      style: TextStyle(
                                          fontSize:
                                              getProportionateScreenHeight(12),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'nanum_square'),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 24, right: 59, top: 12),
                                    child: Text(
                                      _prompt[index][2],
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
                )),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.064,
              top: MediaQuery.of(context).size.height * 0.73,
              child: Image.asset('assets/images/camera.png'),
            )
          ]),
        ),
      ),
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

  List<List<String>> _prompt = [
    ['산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8','라벨을 10개 찍으면 상품이 팡!','산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8'],
    ['산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8','라벨을 10개 찍으면 상품이 팡!','산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8'],
    ['산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8','라벨을 10개 찍으면 상품이 팡!','산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트8']
  ];
}
