import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {
  final BuildContext context;

  LogoutRequested(this.context);

  @override
  List<Object> get props => [context];
}
