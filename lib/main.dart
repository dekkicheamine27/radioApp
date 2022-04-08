import 'package:flutter/services.dart';
import 'package:online_radio/data_provider.dart';
import 'package:online_radio/istaqimTitles.dart';
import 'package:online_radio/mixlrTitles.dart';
import 'package:online_radio/url_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:online_radio/radio_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider<UrlProvider>(
        create: (_) => UrlProvider(),
      ),
      ChangeNotifierProvider<DataProvider>(
        create: (_) => DataProvider(),
      ),
      ChangeNotifierProvider<MixlrTitles>(
        create: (_) => MixlrTitles(),
      ),
      ChangeNotifierProvider<IstaqimTitles>(
        create: (_) => IstaqimTitles(),
      ),
    ], child: RadioApp()),
  );
}
