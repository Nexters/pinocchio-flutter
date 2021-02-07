import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_event.dart';
import 'package:flutter_sancle/utils/camera_utils.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'bloc/camera_state.dart';

class CameraScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<CameraBloc>(
        create: (context) {
          return CameraBloc(cameraUtils: CameraUtils())
            ..add(CameraInitialized());
        },
        child: CameraScreen(),
      ),
    );
  }

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  SvgPicture _currentCameraButtonSvg;
  CameraBloc _cameraBloc;

  @override
  void initState() {
    super.initState();
    _cameraBloc = BlocProvider.of<CameraBloc>(context);
    WidgetsBinding.instance.addObserver(this);
    _currentCameraButtonSvg =
        SvgPicture.asset('assets/icons/ic_camera_button_unpressed.svg');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _cameraBloc = BlocProvider.of<CameraBloc>(context);

    if (!_cameraBloc.isInitialized()) return;

    if (state == AppLifecycleState.inactive) {
      _cameraBloc.add(CameraStopped());
    } else if (state == AppLifecycleState.resumed) {
      _cameraBloc.add(CameraInitialized());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: _cameraView(),
      ),
    );
  }

  Widget _cameraView() {
    return BlocConsumer<CameraBloc, CameraState>(
      listener: (context, state) {
        if (state is CameraFailure) {
          Fluttertoast.showToast(msg: '카메라를 사용할 수 없습니다. 잠시 후 다시 시도해주세요.');
          _closeScreen();
        } else if (state is CameraCaptureSuccess) {
          String path = state.path;
          // TODO 사진 결과 화면 전환
        } else if (state is CameraCaptureFailure) {
          Fluttertoast.showToast(msg: '잠시 후 다시 시도해주세요.');
        }
      },
      builder: (context, state) {
        return Stack(children: <Widget>[
          state is CameraReady
              ? CameraPreview(_cameraBloc.getController())
              : Center(child: CircularProgressIndicator()),
          Positioned(
            top: getProportionateScreenHeight(48),
            left: getProportionateScreenWidth(24),
            child: TouchableOpacity(
              activeOpacity: 0.6,
              onTap: () {
                _closeScreen();
              },
              child: SvgPicture.asset(
                'assets/icons/ic_close_normal.svg',
                height: getProportionateScreenHeight(32),
                width: getProportionateScreenHeight(32),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 145,
              child: Column(
                children: [
                  Divider(height: 1, color: Color(0xFFB6BCC2), thickness: 1),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 24,
                    child: StreamBuilder<Object>(
                        stream: _cameraBloc.selectedIndexStream,
                        initialData: 0,
                        builder: (context, snapshot) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _categoryItem(
                                index: index,
                                isSelected: index == snapshot.data,
                                pictureCategories:
                                    _cameraBloc.pictureCategories,
                              );
                            },
                            itemCount: _cameraBloc.pictureCategories.length,
                          );
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: getProportionateScreenHeight(82),
                    height: getProportionateScreenHeight(82),
                    child: GestureDetector(
                        onTapCancel: () {
                          setState(() {
                            _currentCameraButtonSvg = SvgPicture.asset(
                                'assets/icons/ic_camera_button_unpressed.svg');
                          });
                        },
                        onTapDown: (_) {
                          setState(() {
                            _currentCameraButtonSvg = SvgPicture.asset(
                                'assets/icons/ic_camera_button_pressed.svg');
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            _currentCameraButtonSvg = SvgPicture.asset(
                                'assets/icons/ic_camera_button_unpressed.svg');
                          });
                        },
                        onTap: () {
                          _cameraBloc.add(CameraCaptured());
                        },
                        child: _currentCameraButtonSvg),
                  )
                ],
              ),
            ),
          )
        ]);
      },
    );
  }

  Widget _categoryItem(
      {int index, bool isSelected, List<String> pictureCategories}) {
    return GestureDetector(
      onTap: () {
        _cameraBloc.add(PictureCategoryClicked(index));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 54,
        margin: EdgeInsets.only(
            left: index == 0
                ? getProportionateScreenWidth(24)
                : getProportionateScreenWidth(18)),
        decoration: BoxDecoration(
            color: isSelected ? primaryColor : whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Center(
          child: Text(
            pictureCategories[index],
            style: TextStyle(
              color: blackColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'nanum_square',
            ),
          ),
        ),
      ),
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
