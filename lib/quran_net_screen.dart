import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';
import 'package:online_radio/data_provider.dart';
import 'package:online_radio/istaqimTitles.dart';
import 'package:online_radio/player_bloc%20_quran/player_bloc_quran.dart';
import 'package:online_radio/player_bloc%20_quran_net/player_bloc_quran_net.dart';
import 'package:online_radio/player_bloc/player_bloc.dart';
import 'package:online_radio/url_provider.dart';
import 'package:online_radio/widgets/idle_dots.dart';
import 'package:provider/provider.dart';

class QuranNetScreen extends StatefulWidget {
  @override
  _QuranNetScreenState createState() => _QuranNetScreenState();
}

class _QuranNetScreenState extends State<QuranNetScreen> {
  String _planetRockUrl;
  String _activeUrl;
  
  @override
  void initState() {
    super.initState();
    context.bloc<PlayerBloc>().add(PauseEvent());
    context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
    context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<IstaqimTitles>(context, listen: false).fetchdataTitle();
    try {
      _planetRockUrl = Provider.of<UrlProvider>(context).urls['urlQuranNet'];
    } catch (e) {
      _planetRockUrl = "http://stream.zeno.fm/y6kgq8n5sk8uv";
    }
    if (_planetRockUrl == null || _planetRockUrl == "") {
      _planetRockUrl = "http://stream.zeno.fm/y6kgq8n5sk8uv";
    }

    String titleQuran =
        Provider.of<IstaqimTitles>(context).titleQuranNet['title'];

    if (titleQuran == null) {
      titleQuran = "";
    }

    if (_activeUrl != _planetRockUrl) {
      _activeUrl = _planetRockUrl;
      context.bloc<PlayerBloc>().add(PauseEvent());
      context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      context
          .bloc<PlayerBlocQuranNet>()
          .add(PlayEventQuranNet(url: _activeUrl));
      // context.bloc<PlayerBloc>().add(PauseEvent());
      // context.bloc<PlayerBloc>().add(PauseEvent());
      // context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      
    }

   
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 25),
            child: Icon(Icons.volume_up_outlined, size: 100),
          ),
          Container(
            child: Center(
              child: BlocBuilder<PlayerBlocQuranNet, PlayerStateQuranNet>(
                  builder: (context, state) {
                if (state is PausedStateQuranNet) {
                  return IdleDots(color: Theme.of(context).accentColor);
                } else if (state is PlayingStateQuranNet) {
                  return Loading(
                    indicator: LineScalePulseOutIndicator(),
                    size: 100,
                    color: Theme.of(context).accentColor,
                  );
                } else {
                  throw Exception('Unknown state of bloc');
                }
              }),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.only(
              bottom: 110,
            ),
            height: 50,
            child: FadeAnimatedTextKit(
              repeatForever: true,
              duration: Duration(seconds: 3),
              text: ["يُبـثُّ الآن", titleQuran],
              textStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w800),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Theme.of(context).primaryColor,
        ),
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                ),
                height: 50,
                width: 50,
                child: Icon(
                  Icons.volume_up_outlined,
                  size: 40,
                ),
              ),
            ),
            Text(
              'إذاعـة القرآن الكريم',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Cairo',
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: BlocBuilder<PlayerBlocQuranNet, PlayerStateQuranNet>(
                builder: (context, state) {
                  if (state is PausedStateQuranNet) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        size: 40,
                      ),
                      onPressed: () {
                        // Provider.of<UrlProvider>(context, listen: false)
                        //     .fetchdata();
                        
                        context.bloc<PlayerBloc>().add(PauseEvent());
                        context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
                        context
                            .bloc<PlayerBlocQuranNet>()
                            .add(PlayEventQuranNet(url: _planetRockUrl));
                        // Provider.of<DataProvider>(context, listen: false)
                        //     .fetchdataTitle();
                      },
                    );
                  } else {
                    return IconButton(
                      icon: Icon(
                        Icons.pause,
                        size: 40,
                      ),
                      onPressed: () {
                        
                        // Provider.of<UrlProvider>(context, listen: false)
                        //     .fetchdata();
                        context
                            .bloc<PlayerBlocQuranNet>()
                            .add(PauseEventQuranNet());
                        // Provider.of<DataProvider>(context, listen: false)
                        //     .fetchdataTitle();
                      },
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
