import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageEvent.dart';
import 'package:flutter_sancle/presentation/mypage/bloc/MyPageState.dart';

class MyPageBloc extends Bloc<MyPageEvent, MyPageState> {

  MyPageBloc() : super(MyPageStart());

  @override
  Stream<MyPageState> mapEventToState(MyPageEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }

}