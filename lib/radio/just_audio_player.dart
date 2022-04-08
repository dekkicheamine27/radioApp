import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:online_radio/radio/radio_player.dart';

class JustAudioPlayer extends RadioPlayer {
  final audioPlayer = AudioPlayer();
  var _isUrlSet = false;

  @override
  Future<void> pause() async {
    _isUrlSet = false;
    await audioPlayer.stop();
    return audioPlayer.stop();

  }

  @override
  Future<void> play({@required String url}) async {
    if (!_isUrlSet) {
      await audioPlayer.setUrl(url);
      _isUrlSet = true;
    }
    return audioPlayer.play(url);
  }
}
