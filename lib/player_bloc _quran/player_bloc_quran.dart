import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:online_radio/radio/radio_player.dart';

part 'player_event_quran.dart';
part 'player_state_quran.dart';


class PlayerBlocQuran extends Bloc<PlayerEventQuran, PlayerStateQuran> {
  final RadioPlayer radioPlayer;

  PlayerBlocQuran({@required this.radioPlayer}) : assert(radioPlayer != null);

  @override
  PlayerStateQuran get initialState => PausedStateQuran();

  @override
  Stream<PlayerStateQuran> mapEventToState(
    PlayerEventQuran event,
  ) async* {
    if (event is PlayEventQuran && state is! PlayingStateQuran) {
      radioPlayer.play(url: event.url);
      yield PlayingStateQuran();
    } else if (event is PauseEventQuran) {
      radioPlayer.pause();
      yield PausedStateQuran();
    }
  }
}
