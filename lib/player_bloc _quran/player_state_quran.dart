part of 'player_bloc_quran.dart';

@immutable
abstract class PlayerStateQuran {}

class PlayingStateQuran extends PlayerStateQuran {}

class PausedStateQuran extends PlayerStateQuran {}
