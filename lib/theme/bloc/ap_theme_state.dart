part of 'ap_theme_bloc.dart';

class ApThemeState extends Equatable {
  final ThemeData theme;
  const ApThemeState({this.theme});

  @override
  List<Object> get props => [theme];
}


