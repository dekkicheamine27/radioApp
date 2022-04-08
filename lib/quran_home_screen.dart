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

class QuranScreen extends StatefulWidget {
  @override
  _QuranScreenState createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
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
      _planetRockUrl = Provider.of<UrlProvider>(context).urls['urlQuran'];
    } catch (e) {
      _planetRockUrl = "http://stream.zeno.fm/baftrt2htg8uv";
    }
    if (_planetRockUrl == null || _planetRockUrl == "") {
      _planetRockUrl = "http://stream.zeno.fm/baftrt2htg8uv";
    }

    String titleQuran = Provider.of<IstaqimTitles>(context).titleQuran['title'];

    if (titleQuran == null) {
      titleQuran = "";
    }

    if (_activeUrl != _planetRockUrl) {
      _activeUrl = _planetRockUrl;
      context.bloc<PlayerBloc>().add(PauseEvent());
      context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
      context.bloc<PlayerBlocQuran>().add(PlayEventQuran(url: _activeUrl));
      context.bloc<PlayerBloc>().add(PauseEvent());
      context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());

      // context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
     
    }

   
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 25),
            child: Icon(Icons.menu_book_rounded, size: 100),
          ),
          Container(
            child: Center(
              child: BlocBuilder<PlayerBlocQuran, PlayerStateQuran>(
                  builder: (context, state) {
                if (state is PausedStateQuran) {
                  return IdleDots(color: Theme.of(context).accentColor);
                } else if (state is PlayingStateQuran) {
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
                  Icons.menu_book_rounded,
                  size: 40,
                ),
              ),
            ),
            Text(
              'إذاعـة تفسير القرآن ',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Cairo',
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: BlocBuilder<PlayerBlocQuran, PlayerStateQuran>(
                builder: (context, state) {
                  if (state is PausedStateQuran) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        size: 40,
                      ),
                      onPressed: () {
                        Provider.of<UrlProvider>(context, listen: false)
                            .fetchdata();
                            
                        
                        context.bloc<PlayerBloc>().add(PauseEvent());
                        context
                            .bloc<PlayerBlocQuranNet>()
                            .add(PauseEventQuranNet());
                        context
                            .bloc<PlayerBlocQuran>()
                            .add(PlayEventQuran(url: _planetRockUrl));
                        Provider.of<DataProvider>(context, listen: false)
                            .fetchdataTitle();
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
                        context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
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
