import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/capture_event_response.dart';
import 'package:flutter_sancle/data/model/capture_event_result_response.dart';
import 'package:flutter_sancle/data/model/enum/clothes_color_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/bleach_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/dry_cleaning_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/dry_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/ironing_type.dart';
import 'package:flutter_sancle/data/model/enum/label_symbol/water_type.dart';
import 'package:flutter_sancle/data/network/exception_handler.dart';
import 'package:flutter_sancle/data/repository/capture_event_repository.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/bloc/photo_analysis_inspection_result_bloc.dart';
import 'package:flutter_sancle/presentation/photo_analysis_inspection_result/bloc/photo_analysis_inspection_result_state.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/ingredient_color_util.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'bloc/photo_analysis_inspection_result_event.dart';

class PhotoAnalysisInspectionResultScreen extends StatefulWidget {
  final String imagePath;

  const PhotoAnalysisInspectionResultScreen({Key key, this.imagePath})
      : super(key: key);

  static Route route(CaptureEventResponse response, String imagePath) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<PhotoAnalysisInspectionResultBloc>(
        create: (context) {
          return PhotoAnalysisInspectionResultBloc(CaptureEventRepository())
            ..add(PhotoAnalysisInspectionInitialized(response));
        },
        child: PhotoAnalysisInspectionResultScreen(
          imagePath: imagePath,
        ),
      ),
    );
  }

  @override
  _PhotoAnalysisInspectionResultScreenState createState() =>
      _PhotoAnalysisInspectionResultScreenState();
}

class _PhotoAnalysisInspectionResultScreenState
    extends State<PhotoAnalysisInspectionResultScreen> {
  PhotoAnalysisInspectionResultBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PhotoAnalysisInspectionResultBloc>(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xFFF1EFEE),
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: BlocConsumer<PhotoAnalysisInspectionResultBloc,
            PhotoAnalysisInspectionResultState>(
          builder: (context, state) {
            return state is DataConversionFromSuccess
                ? _buildBody(state.response)
                : _buildLoading();
          },
          listener: (context, state) {
            if (state is DataConversionFromFailure) {
              Fluttertoast.showToast(msg: DEFAULT_ERROR_MSG);
              _closeScreen();
            } else if (state is ErrorReportSuccess) {
              Fluttertoast.showToast(msg: '레포트 보내기 성공');
              _closeScreen();
            } else if (state is EventStatusDoneSuccess) {
              // TODO 최종 결과 화면 전환
            } else if (state is NetworkError) {
              ExceptionHandler.handleException(context, state.dioError);
            }
          },
        ),
      ),
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
            margin: EdgeInsets.only(left: getProportionateScreenWidth(21)),
            child: GestureDetector(
              onTap: () => _closeScreen(),
              child: SvgPicture.asset(
                'assets/icons/ic_close_middle.svg',
                width: getProportionateScreenWidth(34),
                height: getProportionateScreenWidth(34),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: getProportionateScreenWidth(30)),
            child: GestureDetector(
              onTap: () {
                _bloc.add(EventStatusDoneRequested());
              },
              child: Text(
                '다음',
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

  Widget _buildBody(CaptureEventResultResponse response) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderImage(),
          SizedBox(height: 42),
          _buildScreenTitle(),
          SizedBox(height: 20),
          _buildScreenDescription(),
          SizedBox(height: 43),
          _buildAllLabelCategories(response),
          _buildDivider(top: 42),
          _buildIngredientsLayout(response.ingredientList),
          _buildDivider(),
          _buildColorSelectionLayout(),
          _buildFooter(),
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

  Widget _buildScreenTitle() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text.rich(
        TextSpan(
            text: '촬영한 라벨과\n인식한 라벨이 ',
            style: TextStyle(
                fontSize: 24,
                color: sancleDarkColor,
                fontWeight: FontWeight.w400,
                fontFamily: 'nanum_square'),
            children: [
              TextSpan(
                text: '일치',
                style: TextStyle(
                    color: sancleDarkColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'nanum_square'),
              ),
              TextSpan(
                text: '하나요',
                style: TextStyle(
                    color: sancleDarkColor,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'nanum_square'),
              ),
            ]),
      ),
    );
  }

  Widget _buildScreenDescription() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        '일치하지 않은 라벨이 있다면 해당하는\n아이콘을 클릭하여 레포트를 보내주세요.',
        style: TextStyle(
          fontFamily: 'nanum_square',
          fontSize: 14,
          color: sancleDarkColor,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildAllLabelCategories(CaptureEventResultResponse response) {
    WaterWashingType waterType =
        getWaterWashingTypeFromString(response?.waterType);
    BleachType bleachType = getBleachTypeFromString(response?.bleachType);
    DryType dryType = getDryTypeFromString(response?.dryType);
    IroningType ironingType = getIroningTypeFromString(response?.ironingType);
    DryCleaningType dryCleaning =
        getDryCleaningTypeFromString(response?.dryCleaning);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabelCategoryItem(waterType.getUIIconName(), '물세탁'),
          _buildLabelCategoryItem(bleachType.getUIIconName(), '산소 표'),
          _buildLabelCategoryItem(dryType.getUIIconName(), '건조'),
          _buildLabelCategoryItem(ironingType.getUIIconName(), '다림질'),
          _buildLabelCategoryItem(dryCleaning.getUIIconName(), '드라이'),
        ],
      ),
    );
  }

  Widget _buildLabelCategoryItem(String iconSvgName, String title) {
    return Column(
      children: [
        SvgPicture.asset(iconSvgName),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'nanum_square',
            color: sancleDarkColor,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget _buildIngredientsLayout(List<IngredientList> ingredientList) {
    List<Color> ingredientColors =
        IngredientColorUtil.getIngredientColors(ingredientList.length);
    return Container(
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
          _buildIngredientChart(ingredientList, ingredientColors),
          SizedBox(height: 28),
          _buildIngredientItems(ingredientList, ingredientColors),
        ],
      ),
    );
  }

  Widget _buildIngredientChart(
      List<IngredientList> ingredientList, List<Color> ingredientColors) {
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
      List<IngredientList> ingredientList, List<Color> ingredientColors) {
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

  Widget _buildColorSelectionLayout() {
    return Container(
      padding: EdgeInsets.only(top: 42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 30),
            child: Text(
              '색상 선택',
              style: TextStyle(
                fontSize: 18,
                color: sancleDarkColor,
                fontFamily: 'nanum_square',
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 46,
            child: StreamBuilder<Object>(
                stream: _bloc.selectedIndexStream,
                initialData: 0,
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildColorSelectionItem(
                          index,
                          index == _bloc.clothesColorTypes.length - 1,
                          index == snapshot.data);
                    },
                    itemCount: _bloc.clothesColorTypes.length,
                  );
                }),
          ),
          SizedBox(height: 55),
        ],
      ),
    );
  }

  Widget _buildColorSelectionItem(int index, bool isLastItem, bool isSelected) {
    ClothesColor color = _bloc.clothesColorTypes[index].getColorWidget();
    return GestureDetector(
      onTap: () {
        _bloc.add(ClothesColorTypeSelected(index));
      },
      child: Container(
        margin: EdgeInsets.only(
            left: index == 0 ? 30 : 22, right: isLastItem ? 22 : 0),
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(width: 1, color: color.borderColor),
          color: isSelected ? color.selectedColor : color.unSelectedColor,
        ),
      ),
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

  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 0.5,
          color: Color(0x660F1012),
        ),
        TouchableOpacity(
          onTap: () => _bloc.add(ErrorReportRequested()),
          activeOpacity: 0.6,
          child: Container(
            margin: EdgeInsets.only(top: 18, bottom: 28, left: 30, right: 30),
            width: double.infinity,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Color(0x660F1012)),
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오류 레포트 보내기',
                  style: TextStyle(
                    color: sancleDarkColor,
                    fontSize: 16.0,
                    fontFamily: 'nanum_square',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 8),
                  child: SvgPicture.asset("assets/icons/ic_next_guide.svg"),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  void _closeScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }

  Widget _buildLoading() {
    return Center(
      child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(primaryColor)),
    );
  }
}
