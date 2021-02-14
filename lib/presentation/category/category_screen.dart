import 'package:flutter/material.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();

  static Route route() {
    return MaterialPageRoute(builder: (_) {
      return CategoryScreen();
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
            padding: EdgeInsets.symmetric(horizontal: 30),
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
                Text('title',
                    style: TextStyle(
                        fontSize: getProportionateScreenHeight(16),
                        fontWeight: FontWeight.w700,
                        fontFamily: 'nanum_square')),
                SizedBox(width: 10)
              ],
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(30)),
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return clothItem(index);
              })
        ],
      )),
    );
  }

  Widget clothItem(int index) {
    return Container(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        // actionExtentRatio: 0.25,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(color: shadowColor, offset: Offset(1, 2), blurRadius: 2)
              ]),
          child: ListTile(
            leading: SvgPicture.asset('assets/icons/red.svg'),
            title: Text('자라에서 구매한 니트 최대 18자',
                style: TextStyle(
                    fontSize: getProportionateScreenHeight(14),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'nanum_square')),
          ),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            color: Colors.blue,
            iconWidget: SvgPicture.asset('assets/icons/delete.svg'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
