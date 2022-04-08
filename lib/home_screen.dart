import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/line_scale_pulse_out_indicator.dart';
import 'package:loading/loading.dart';
import 'package:online_radio/data_provider.dart';
import 'package:online_radio/istaqimTitles.dart';
import 'package:online_radio/mixlrTitles.dart';
import 'package:online_radio/player_bloc%20_quran/player_bloc_quran.dart';
import 'package:online_radio/player_bloc%20_quran_net/player_bloc_quran_net.dart';
import 'package:online_radio/url_provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:online_radio/widgets/idle_dots.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'player_bloc/player_bloc.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String title = "";
  bool is_live = false;
  String _planetRockUrl;

  String activeUrl;
  @override
  void initState() {
    super.initState();
    
    context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
    context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
    
  }

  Widget _buildTitle(bool live) {
    if (live) {
      return FadeAnimatedTextKit(
        repeatForever: true,
        duration: Duration(seconds: 3),
        text: [" يُبـثُّ الآن", " درس مُبـاشــر", title],
        textStyle: TextStyle(
            fontSize: 12, fontFamily: 'Cairo', fontWeight: FontWeight.w800),
        textAlign: TextAlign.center,
      );
    } else {
      return FadeAnimatedTextKit(
        repeatForever: true,
        duration: Duration(seconds: 3),
        text: ["يُبـثُّ الآن", title],
        textStyle: TextStyle(
            fontSize: 14, fontFamily: 'Cairo', fontWeight: FontWeight.w800),
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    is_live = false;
    Provider.of<IstaqimTitles>(context, listen: false).fetchdataTitle();
    Provider.of<DataProvider>(context, listen: false).fetchdataTitle();

    try {
      _planetRockUrl = Provider.of<UrlProvider>(context).urls['urlVoice'];
    } catch (e) {
      _planetRockUrl = "http://stream.zeno.fm/6s7yg5vgtg8uv";
    }

    title = Provider.of<IstaqimTitles>(context).titleVoice['title'];
    is_live = false;

    if (Provider.of<DataProvider>(context).dataplus["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataplus["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleplus'] == "") {
          title = Provider.of<DataProvider>(context)
              .dataplus["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleplus'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).dataatrujah["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataatrujah["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleAtrujah'] == "") {
          title = Provider.of<DataProvider>(context)
              .dataatrujah["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleAtrujah'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }
    if (Provider.of<DataProvider>(context).dataAbbas["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataAbbas["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleAbbas'] == "") {
          title = Provider.of<DataProvider>(context)
              .dataAbbas["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleAbbas'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).dataAbad["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataAbad["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleAbad'] == "") {
          title = title = Provider.of<DataProvider>(context)
              .dataAbad["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleAbad'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).dataruhaily["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataruhaily["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleRuhaily'] == "") {
          title = Provider.of<DataProvider>(context)
              .dataruhaily["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleRuhaily'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).datayatou["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .datayatou["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleyatou'] == "") {
          title = title = Provider.of<DataProvider>(context)
              .dataAbad["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleyatou'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).datajelwah["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .datajelwah["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleJelwah'] == "") {
          title = Provider.of<DataProvider>(context)
              .datajelwah["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleJelwah'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }
    if (Provider.of<DataProvider>(context).datarezak["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .datarezak["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titlerezak'] == "") {
          title = Provider.of<DataProvider>(context)
              .datarezak["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titlerezak'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

    if (Provider.of<DataProvider>(context).dataMidkhali["is_live"] == true) {
      try {
        _planetRockUrl = Provider.of<DataProvider>(context)
            .dataMidkhali["current_broadcast"]["streams"]["progressive"]["url"];

        if (Provider.of<MixlrTitles>(context).titles['titleMidkhali'] == "") {
          title = Provider.of<DataProvider>(context)
              .dataMidkhali["current_broadcast"]["title"];
        } else {
          title = Provider.of<MixlrTitles>(context).titles['titleMidkhali'];
        }
      } catch (e) {
        throw e;
      }
      is_live = true;
    }

   


    if (_planetRockUrl == null || _planetRockUrl == "") {
      _planetRockUrl = "http://stream.zeno.fm/6s7yg5vgtg8uv";
      is_live = false;
    }

    if (title == null) {
      title = "";
      is_live = false;
    }

    if (activeUrl != _planetRockUrl) {
      activeUrl = _planetRockUrl;
      context.bloc<PlayerBloc>().add(PauseEvent());
      context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
      context.bloc<PlayerBloc>().add(PlayEvent(url: activeUrl));
      context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      context.bloc<PlayerBlocQuranNet>().add(PauseEventQuranNet());
      // context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      // context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
      // MediaNotification.hideNotification();
     
    }

    return Scaffold(
      appBar: null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 25),
            child: Icon(FontAwesomeIcons.microphoneAlt, size: 100),
          ),
          Container(
            child: Center(
              child: BlocBuilder<PlayerBloc, PlayerState>(
                  builder: (context, state) {
                if (state is PausedState) {
                  return IdleDots(color: Theme.of(context).accentColor);
                } else if (state is PlayingState) {
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
            margin: EdgeInsets.only(
              bottom: 110,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: _buildTitle(is_live),
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
                height: 50,
                width: 50,
                child: Icon(
                  Icons.mic,
                  size: 40,
                ),
              ),
            ),
            Text(
              'إذاعـة الدروس',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontFamily: 'Cairo',
                fontSize: 22,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: BlocBuilder<PlayerBloc, PlayerState>(
                builder: (context, state) {
                  if (state is PausedState) {
                    return IconButton(
                      icon: Icon(
                        Icons.play_arrow_rounded,
                        size: 40,
                      ),
                      onPressed: () async {
                      
                        // Provider.of<UrlProvider>(context, listen: false)
                        //     .fetchdata();
                        context.bloc<PlayerBlocQuran>().add(PauseEventQuran());
                        context
                            .bloc<PlayerBlocQuranNet>()
                            .add(PauseEventQuranNet());
                        context
                            .bloc<PlayerBloc>()
                            .add(PlayEvent(url: _planetRockUrl));
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
                      onPressed: () async {
                        
                        context.bloc<PlayerBloc>().add(PauseEvent());
                        // await Provider.of<UrlProvider>(context, listen: false)
                        //     .fetchdata();
                        // await Provider.of<DataProvider>(context, listen: false)
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
