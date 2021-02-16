import 'package:flutter/material.dart';
import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/presentation/edit/edit_screen.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CategoryScreen extends StatefulWidget {
  final MyPageResponse data;
  final String category;

  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  const CategoryScreen({this.data, this.category}) : super();

  static Route route(MyPageResponse event, String category) {
    return MaterialPageRoute(builder: (_) {
      return CategoryScreen(data: event, category: category);
    });
  }
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 56,
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TouchableOpacity(
                  activeOpacity: 0.6,
                  child: Container(
                      height: getProportionateScreenHeight(56),
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset("assets/icons/back_button.svg")),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Text(widget.category,
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'nanum_square')),
                SizedBox(width: getProportionateScreenWidth(10))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(30)),
                itemCount: 10,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return clothItem(index);
                }),
          )
        ],
      )),
    );
  }

  Widget clothItem(int index) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(10)),
          Slidable(
            actionPane: SlidableDrawerActionPane(),
            // actionExtentRatio: 0.25,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                        color: shadowColor, offset: Offset(1, 2), blurRadius: 2)
                  ]),
              child: Padding(
                padding: EdgeInsets.only(
                    top: getProportionateScreenHeight(16),
                    bottom: getProportionateScreenHeight(16),
                    left: getProportionateScreenWidth(16)),
                child: Row(
                  children: [
                    // SvgPicture.asset('assets/icons/red.svg'),
                    Image.asset('assets/icons/red.png'),
                    SizedBox(
                      width: 10,
                    ),
                    Text('자라에서 구매한 니트 최대 18자',
                        style: TextStyle(
                            fontSize: getProportionateScreenHeight(14),
                            fontWeight: FontWeight.w700,
                            fontFamily: 'nanum_square')),
                    TouchableOpacity(
                      activeOpacity: 0.6,
                      child: Container(
                          child: SvgPicture.asset("assets/icons/edit.svg")),
                      onTap: () {
                        Navigator.push(context, EditScreen.route());
                      },
                    ),
                  ],
                ),
              ),
            ),
            secondaryActions: <Widget>[
              Container(
                child: IconSlideAction(
                  color: Color.fromRGBO(241, 239, 238, 0),
                  iconWidget: SvgPicture.asset('assets/icons/delete.svg'),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
