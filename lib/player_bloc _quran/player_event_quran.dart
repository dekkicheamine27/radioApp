part of 'player_bloc_quran.dart';

@immutable
abstract class PlayerEventQuran {}

class PlayEventQuran extends PlayerEventQuran {
  final String url;
  PlayEventQuran({@required this.url}) : assert(url != null);
}

class PauseEventQuran extends PlayerEventQuran {}
