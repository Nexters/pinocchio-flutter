import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/bleach_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/dry_cleaning_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/dry_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/ironing_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/water_type.dart';
import 'package:flutter_sancle/data/model/ingredient.dart';
import 'package:flutter_sancle/data/model/result_view_response.dart';
import 'package:flutter_sancle/data/network/exception_handler.dart';
import 'package:flutter_sancle/data/repository/result_view_repository.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/ingredient_color_util.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bloc/photo_analysis_final_result_bloc.dart';
import 'bloc/photo_analysis_final_result_event.dart';
import 'bloc/photo_analysis_final_result_state.dart';

class PhotoAnalysisFinalResultScreen extends StatefulWidget {
  final String imagePath;

  const PhotoAnalysisFinalResultScreen({Key key, this.imagePath})
      : super(key: key);

  static Route route(String eventId, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisFinalResultBloc>(
        create: (context) {
          return PhotoAnalysisFinalResultBloc(ResultViewRepository())
            ..add(PhotoAnalysisFinalResultInitialized(eventId));
        },
        child: PhotoAnalysisFinalResultScreen(
          imagePath: imagePath,
        ),
      ),
    );
  }

  @override
  _PhotoAnalysisFinalResultScreenState createState() =>
      _PhotoAnalysisFinalResultScreenState();
}

class _PhotoAnalysisFinalResultScreenState
    extends State<PhotoAnalysisFinalResultScreen> {
  ResultViewResponse _response;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF1EFEE),
      appBar: _buildAppBar(),
      body: SafeArea(
          top: false,
          child: BlocConsumer<PhotoAnalysisFinalResultBloc,
              PhotoAnalysisFinalResultState>(
            listener: (context, state) {
              if (state is NetworkError) {
                ExceptionHandler.handleException(context, state.dioError);
              }
            },
            builder: (context, state) {
              if (state is ResultViewDataRequestSuccess) {
                _response = state.response;
              }
              return _response != null ? _buildBody() : _buildLoading();
            },
          )),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: getProportionateScreenWidth(17)),
            child: GestureDetector(
              onTap: () => _closeScreen(),
              child: SvgPicture.asset(
                'assets/icons/ic_back_middle.svg',
                width: getProportionateScreenWidth(34),
                height: getProportionateScreenWidth(34),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.only(right: getProportionateScreenWidth(22)),
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: '저장 완료');
              },
              child: Text(
                '저장',
                style: TextStyle(
                  fontSize: 16.0,
                  color: sancleDarkColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'nanum_square',
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFFF1EFEE),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderImage(),
          SizedBox(height: 42),
          _buildScreenText(),
          _buildDivider(),
          _buildIngredientsLayout(),
          _buildDivider(),
          _buildAllLabelCategoriesLayout(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Image.file(
        File(widget.imagePath),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildScreenText() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            _response?.title,
            style: TextStyle(
                fontSize: 24,
                color: sancleDarkColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'nanum_square'),
          ),
          SizedBox(height: 30),
          Text(
            _response?.description,
            style: TextStyle(
              fontFamily: 'nanum_square',
              fontSize: 16,
              color: sancleDarkColor,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 42),
        ],
      ),
    );
  }

  Widget _buildIngredientsLayout() {
    List<Ingredient> ingredients = _response?.ingredients ?? [];
    List<Color> ingredientColors =
        IngredientColorUtil.getIngredientColors(ingredients.length);
    return Visibility(
      visible: ingredients.isNotEmpty,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 42, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '혼용률',
              style: TextStyle(
                fontSize: 18,
                color: sancleDarkColor,
                fontFamily: 'nanum_square',
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 30),
            _buildIngredientChart(ingredients, ingredientColors),
            SizedBox(height: 28),
            _buildIngredientItems(ingredients, ingredientColors)
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChart(
      List<Ingredient> ingredientList, List<Color> ingredientColors) {
    return Container(
      width: double.infinity,
      height: 22,
      child: Row(
        children: [
          for (int i = 0; i < ingredientList.length; i++)
            Expanded(
              flex: ingredientList[i].percentage,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(i == 0 ? 2 : 0),
                    topRight:
                        Radius.circular(i == ingredientList.length - 1 ? 2 : 0),
                    bottomLeft: Radius.circular(i == 0 ? 2 : 0),
                    bottomRight:
                        Radius.circular(i == ingredientList.length - 1 ? 2 : 0),
                  ),
                  color: ingredientColors[i],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIngredientItems(
      List<Ingredient> ingredientList, List<Color> ingredientColors) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(top: index == 0 ? 0 : 15),
          child: Row(
            children: [
              Container(
                width: 17,
                height: 17,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: ingredientColors[index],
                ),
              ),
              SizedBox(width: 12),
              Text(
                ingredientList[index].name,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'nanum_square',
                  fontWeight: FontWeight.w400,
                  color: sancleDarkColor,
                ),
              ),
              Spacer(),
              Text(
                '${ingredientList[index].percentage}%',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'nanum_square',
                  fontWeight: FontWeight.w400,
                  color: sancleDarkColor,
                ),
              ),
            ],
          ),
        );
      },
      itemCount: ingredientList.length,
    );
  }

  Widget _buildAllLabelCategoriesLayout() {
    WaterWashingType waterType =
        getWaterWashingTypeFromString(_response?.waterType);
    BleachType bleachType = getBleachTypeFromString(_response?.bleachType);
    DryType dryType = getDryTypeFromString(_response?.dryType);
    IroningType ironingType = getIroningTypeFromString(_response?.ironingType);
    DryCleaningType dryCleaning =
        getDryCleaningTypeFromString(_response?.dryCleaning);

    return Container(
      margin: EdgeInsets.only(top: 42, bottom: 95, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '라벨',
            style: TextStyle(
              fontSize: 18,
              color: sancleDarkColor,
              fontFamily: 'nanum_square',
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          _buildLabelCategoryItem(waterType.getUIIconName(), '물세탁',
              waterType?.getUIDescription() ?? ''),
          SizedBox(height: getProportionateScreenHeight(30)),
          _buildLabelCategoryItem(bleachType.getUIIconName(), '산소 표백',
              bleachType?.getUiDescription() ?? ''),
          SizedBox(height: getProportionateScreenHeight(30)),
          _buildLabelCategoryItem(
              dryType.getUIIconName(), '건조', dryType?.getUIDescription() ?? ''),
          SizedBox(height: getProportionateScreenHeight(30)),
          _buildLabelCategoryItem(ironingType.getUIIconName(), '다림질',
              ironingType?.getUIDescription() ?? ''),
          SizedBox(height: getProportionateScreenHeight(30)),
          _buildLabelCategoryItem(dryCleaning.getUIIconName(), '드라이',
              dryCleaning?.getUIDescription() ?? ''),
        ],
      ),
    );
  }

  Widget _buildLabelCategoryItem(
      String iconSvgName, String title, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          iconSvgName,
          width: 54,
          height: 54,
        ),
        SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: sancleDarkColor,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'nanum_square'),
            ),
            SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                  fontSize: 12,
                  color: sancleDarkColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'nanum_square'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildDivider({double top = 0}) {
    return Container(
      margin: EdgeInsets.only(top: top),
      color: Color(0xFFDBDBDB),
      width: double.infinity,
      height: 6,
    );
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primaryColor)),
    );
  }

  void _closeScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
