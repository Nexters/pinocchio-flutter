import 'package:flutter/material.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return EditScreen();
    });
  }
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: getProportionateScreenHeight(56),
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TouchableOpacity(
                      activeOpacity: 0.6,
                      child: Container(
                          height: getProportionateScreenHeight(56),
                          alignment: Alignment.centerLeft,
                          child: SvgPicture.asset("assets/icons/icon_x_png.svg")),
                        // child: Image.asset('assets/icons/icon_x_png.png')),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text('상의',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(16),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'nanum_square')),
                    TouchableOpacity(
                      activeOpacity: 0.6,
                      child: Container(
                          height: getProportionateScreenHeight(56),
                          alignment: Alignment.centerLeft,
                          child: Text('확인',
                              style: TextStyle(
                                  fontSize: getProportionateScreenHeight(16),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'nanum_square'))),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
                child: TextField(
                  cursorColor: primaryColor,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: textColor)
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor)
                    ),
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: textColor)
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
