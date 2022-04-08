part of 'ap_theme_bloc.dart';

class ApThemeEvent extends Equatable {
  final ThemeData theme;
  const ApThemeEvent({this.theme});

  @override
  List<Object> get props => [theme];
}
