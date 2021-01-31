import 'package:flutter/material.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) {
        return HomeScreen();
      },
    );
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
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
              Text('안녕하세요!',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(30),
                    fontWeight: FontWeight.w300,
                    fontFamily: 'nanum_square'),
              ),
              SizedBox(height: 32),
              Text('현재 산타클로즈에 쌓인 옷',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(16),
                    fontWeight: FontWeight.w400,
                    fontFamily: 'nanum_square'),
              ),
              SizedBox(height: 10),
              Text('100,000벌!',
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
                Container(
                  padding: EdgeInsets.only(top: 17, left: 24),
                  child: Row(
                    children: <Widget>[
                        for (int i = 0; i < 3; i++)
                        if (i == 1) ...[_circleBar(true)] else
                        _circleBar(false),
                      ],
                    ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: controller,
                    itemCount: 3,
                    onPageChanged: (page){

                    },
                    itemBuilder: (context, index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 59, top: 18),
                            child: Text('산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(22),
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'nanum_square'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 59, top: 10),
                            child: Text('라벨을 10개를 찍으면 상품이 팡!',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(12),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'nanum_square'),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 24, right: 59, top: 12),
                            child: Text('산타클로즈에 라벨을 쌓아주세요 2줄가이드 라인하이트 8',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(14),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'nanum_square'),
                            ),
                          ),
                        ],
                      );
                    }
                  ),
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
    );
  }

  Widget _circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 2),
      height: getProportionateScreenHeight(4),
      width: isActive ? getProportionateScreenWidth(14) :getProportionateScreenWidth(4),
      decoration: BoxDecoration(
          color: isActive ? primaryColor : textDisableColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }



  List<List<String>> _prompt = [

  ];
}
