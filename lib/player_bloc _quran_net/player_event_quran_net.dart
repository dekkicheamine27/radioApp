part of 'player_bloc_quran_net.dart';

@immutable
abstract class PlayerEventQuranNet {}

class PlayEventQuranNet extends PlayerEventQuranNet {
  final String url;
  PlayEventQuranNet({@required this.url}) : assert(url != null);
}

class PauseEventQuranNet extends PlayerEventQuranNet {}
