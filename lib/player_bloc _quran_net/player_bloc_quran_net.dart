import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_radio/radio/radio_player.dart';

part 'player_event_quran_net.dart';
part 'player_state_quran_net.dart';


class PlayerBlocQuranNet extends Bloc<PlayerEventQuranNet, PlayerStateQuranNet> {
  final RadioPlayer radioPlayer;

  PlayerBlocQuranNet({@required this.radioPlayer}) : assert(radioPlayer != null);

  @override
  PlayerStateQuranNet get initialState => PausedStateQuranNet();

  @override
  Stream<PlayerStateQuranNet> mapEventToState(
    PlayerEventQuranNet event,
  ) async* {
    if (event is PlayEventQuranNet && state is! PlayingStateQuranNet) {
      radioPlayer.play(url: event.url);
      yield PlayingStateQuranNet();
    } else if (event is PauseEventQuranNet) {
      radioPlayer.pause();
      yield PausedStateQuranNet();
    }
  }
}
