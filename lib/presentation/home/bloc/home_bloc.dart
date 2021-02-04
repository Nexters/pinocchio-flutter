import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_event.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final StreamController _currentPageController = StreamController<int>();
  int page;
  Stream<int> _currentPageStream;

  final _pageController = PageController();

  HomeBloc() : super(HomeStart()) {
    _currentPageStream = _currentPageController.stream;
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is HomePageSlide) {
      page = event.page;
      _pageController.jumpToPage(page);
      _currentPageController.add(page);
    }

    if (event is HomeToMypage) {
      yield MypageStart();
    }

    if (event is PermissionRequested) {
      yield* _requestPermission();
    }
  }

  Stream<int> get currentPage => _currentPageStream;

  get pageController => _pageController;

  Stream<HomeState> _requestPermission() async* {
    yield StateIgnored();
    if (await Permission.camera.request().isGranted) {
      try {
        List<CameraDescription> cameras = await availableCameras();
        if (cameras.isNotEmpty) {
          yield PermissionIsGranted(cameras);
        } else {
          /// 휴대폰에서 카메라가 사용 불가능 한 경우
          yield PermissionError();
        }
      } on CameraException {
        yield PermissionError();
      }
    } else {
      yield PermissionIsDenied();
    }
  }
}
