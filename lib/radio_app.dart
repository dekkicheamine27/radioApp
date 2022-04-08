import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_radio/deviation.dart';
import 'package:online_radio/home_screen.dart';
import 'package:online_radio/istaqimTitles.dart';
import 'package:online_radio/mixlrTitles.dart';
import 'package:online_radio/player_bloc%20_quran/player_bloc_quran.dart';
import 'package:online_radio/player_bloc%20_quran_net/player_bloc_quran_net.dart';
import 'package:online_radio/player_bloc/player_bloc.dart';
import 'package:online_radio/quran_home_screen.dart';
import 'package:online_radio/quran_net_screen.dart';
import 'package:online_radio/radio/just_audio_player.dart';
import 'package:online_radio/radio/radio_player.dart';
import 'package:online_radio/theme/bloc/ap_theme_bloc.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'data_provider.dart';
import 'player_bloc/player_bloc.dart';
import 'url_provider.dart';

class RadioApp extends StatefulWidget {
  @override
  _RadioAppState createState() => _RadioAppState();
}

class _RadioAppState extends State<RadioApp> {
  Widget chooses;
  

  @override
  void initState() {
    super.initState();
   
    provider.Provider.of<UrlProvider>(context, listen: false).fetchdata();

    provider.Provider.of<IstaqimTitles>(context, listen: false)
        .fetchdataUrls()
        .then((_) => provider.Provider.of<DataProvider>(context, listen: false)
            .fetchdataTitle());
    provider.Provider.of<DataProvider>(context, listen: false)
        .fetchdataMixlrUrls()
        .then((_) => provider.Provider.of<DataProvider>(context, listen: false)
            .fetchdataTitle());
    provider.Provider.of<MixlrTitles>(context, listen: false).fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    if (provider.Provider.of<DataProvider>(context).datayatou["is_live"] ==
        null) {
      chooses = Waiting();
    } else {
      chooses = Deviation();
    }

    final RadioPlayer radioPlayer = JustAudioPlayer();
    final RadioPlayer radioPlayerQuran = JustAudioPlayer();
    final RadioPlayer radioPlayerQuranNet = JustAudioPlayer();
    return BlocProvider<ApThemeBloc>(
      create: (context) => ApThemeBloc(),
      child: BlocBuilder<ApThemeBloc, ApThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'إذاعة فاستقم كما أمرت',
            debugShowCheckedModeBanner: false,
            theme: state.theme,
            home: MultiBlocProvider(
              providers: [
                BlocProvider<PlayerBloc>(
                  create: (context) => PlayerBloc(radioPlayer: radioPlayer),
                  child: QuranScreen(),
                ),
                BlocProvider<PlayerBlocQuran>(
                  create: (context) =>
                      PlayerBlocQuran(radioPlayer: radioPlayerQuran),
                  child: HomeScreen(),
                ),
                BlocProvider<PlayerBlocQuranNet>(
                  create: (context) =>
                      PlayerBlocQuranNet(radioPlayer: radioPlayerQuranNet),
                  child: QuranNetScreen(),
                ),
              ],
              child: chooses,
            ),
          );
        },
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}

class Waiting extends StatefulWidget {
  @override
  _WaitingState createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  void initState() {
    super.initState();
    initTimer();
  }

  void initTimer() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => RadioApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 300, child: Image.asset('assets/images/image.png')),
            SizedBox(),
            SpinKitCircle(
              color: Colors.orangeAccent.shade100,
              size: 120,
            ),
            Text(
              "..يرجى الانتظار",
              style: TextStyle(fontSize: 16, fontFamily: 'Cairo'),
            )
          ],
        ),
      ),
    );
  }
}
