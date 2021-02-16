import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/data/model/home_response.dart';
import 'package:flutter_sancle/data/model/mypage_response.dart';
import 'package:flutter_sancle/data/repository/home_repository.dart';
import 'package:flutter_sancle/data/repository/mypage_repository.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_event.dart';
import 'package:flutter_sancle/presentation/home/bloc/home_state.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository;
  final MyPageRepository _myPageRepository;

  final StreamController _currentPageController = StreamController<int>();
  final StreamController _notiController = StreamController<HomeResponse>();
  final StreamController _clothInfoController = StreamController<MyPageResponse>();

  Stream<int> _currentPageStream;
  Stream<HomeResponse> _notiStream;
  Stream<MyPageResponse> _clothInfoStream;

  int page;

  final _pageController = PageController();

  HomeBloc(this._homeRepository, this._myPageRepository) : super(HomeStart()) {
    _currentPageStream = _currentPageController.stream;
    _notiStream = _notiController.stream;
    _clothInfoStream = _clothInfoController.stream;
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

    if (event is GetNotice){
      HomeResponse _homeInfo = new HomeResponse();
      _homeInfo = await _homeRepository.getHomeInfo();
      _notiController.add(_homeInfo);

      MyPageResponse _myPageResponse = new MyPageResponse();
      _myPageResponse = await _myPageRepository.getMyClothInfo();
      _clothInfoController.add(_myPageResponse);

      yield GetNoti();
    }
  }

  Stream<int> get currentPage => _currentPageStream;

  Stream<HomeResponse> get notiInfo => _notiStream;

  Stream<MyPageResponse> get clothInfo => _clothInfoStream;

  get pageController => _pageController;

  Stream<HomeState> _requestPermission() async* {
    yield StateIgnored();
    if (await Permission.camera.request().isGranted) {
      yield PermissionIsGranted();
    } else {
      yield PermissionIsDenied();
    }
  }
}
