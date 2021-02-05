import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageEvent.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';

class MyPageBloc extends Bloc<MyPageEvent, MyPageState> {
  final StreamController _currentPageController = StreamController<int>();
  int page;
  Stream<int> _currentPageStream;

  final _pageController = PageController();

  MyPageBloc() : super(MyPageStart()){
    _currentPageStream = _currentPageController.stream;
  }

  @override
  Stream<MyPageState> mapEventToState(MyPageEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

  Stream<int> get currentPage => _currentPageStream;

  get pageController => _pageController;
}