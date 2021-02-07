import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_bloc.dart';
import 'package:flutter_sancle/presentation/camera/bloc/camera_event.dart';
import 'package:flutter_sancle/utils/constants.dart';
import 'package:flutter_sancle/utils/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touchable_opacity/touchable_opacity.dart';
import 'bloc/camera_state.dart';

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraScreen(this.cameras);

  static Route route(List<CameraDescription> cameras) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<CameraBloc>(
        create: (context) {
          return CameraBloc()..add(PictureDataRequested());
        },
        child: CameraScreen(cameras),
      ),
    );
  }

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController _controller;
  SvgPicture currentCameraButtonSvg;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    currentCameraButtonSvg =
        SvgPicture.asset('assets/icons/ic_camera_button_unpressed.svg');
    onNewCameraSelected(widget.cameras[0]);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (_controller != null) {
        onNewCameraSelected(_controller.description);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
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
    if (_controller == null || !_controller.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    } else {
      return BlocBuilder<CameraBloc, CameraState>(
        builder: (context, state) {
          if (state is PictureDataLoaded) {
            return Stack(children: <Widget>[
              CameraPreview(_controller),
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
                      Divider(
                          height: 1, color: Color(0xFFB6BCC2), thickness: 1),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 24,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return _categoryItem(
                                index: index,
                                selectedPosition: state.selectedPosition,
                                pictureCategories: state.pictureCategories);
                          },
                          itemCount: state.pictureCategories.length,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        width: getProportionateScreenHeight(82),
                        height: getProportionateScreenHeight(82),
                        child: GestureDetector(
                            onTapCancel: () {
                              setState(() {
                                currentCameraButtonSvg = SvgPicture.asset(
                                    'assets/icons/ic_camera_button_unpressed.svg');
                              });
                            },
                            onTapDown: (_) {
                              setState(() {
                                currentCameraButtonSvg = SvgPicture.asset(
                                    'assets/icons/ic_camera_button_pressed.svg');
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                currentCameraButtonSvg = SvgPicture.asset(
                                    'assets/icons/ic_camera_button_unpressed.svg');
                              });
                            },
                            onTap: () {},
                            child: currentCameraButtonSvg),
                      )
                    ],
                  ),
                ),
              )
            ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      );
    }
  }

  Widget _categoryItem(
      {int index, int selectedPosition, List<String> pictureCategories}) {
    return GestureDetector(
      onTap: () {
        BlocProvider.of<CameraBloc>(context).add(PictureCategoryClicked(index));
      },
      child: Container(
        width: 54,
        margin: EdgeInsets.only(
            left: index == 0
                ? getProportionateScreenWidth(24)
                : getProportionateScreenWidth(18)),
        decoration: BoxDecoration(
            color: index == selectedPosition ? primaryColor : whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Center(
          child: Container(
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
      ),
    );
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(cameraDescription, ResolutionPreset.veryHigh,
        enableAudio: false);

    _controller.addListener(() {
      if (mounted) setState(() {});
      if (_controller.value.hasError) {
        _closeScreen();
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (_) {
      _closeScreen();
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _closeScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
