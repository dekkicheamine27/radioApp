import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:online_radio/theme/app_theme.dart';

part 'ap_theme_event.dart';
part 'ap_theme_state.dart';

class ApThemeBloc extends Bloc<ApThemeEvent, ApThemeState> {
 

 
 
  

  @override
  Stream<ApThemeState> mapEventToState(
    ApThemeEvent event,
  ) async* {
    if (event is ApThemeEvent) {
      yield ApThemeState(theme: event.theme);
    }
    // TODO: implement mapEventToState
  }

  @override
  // TODO: implement initialState
  ApThemeState get initialState => ApThemeState(theme: AppTheme.darkTheme);
}
