import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class IstaqimTitles with ChangeNotifier {
  bool fin = false;
   Map<String, dynamic> aPI = {};
  String apiVoice;
  String apiQuran;
  String apiQuaranNet;
  Map<String, dynamic> titleVoice = {};
  Map<String, dynamic> titleQuran = {};
  Map<String, dynamic> titleQuranNet = {};

  Future<void> fetchdataUrls() async {
   
    const urlf =
        'https://radio-tazgait27-default-rtdb.firebaseio.com/url/titlesIstaqim.json';

    try {
      final http.Response url = await http.get(urlf);
      final extradataIstaqimTitles = json.decode(url.body) as Map<String, dynamic>;
      aPI = extradataIstaqimTitles;
    } catch (error) {
      throw error;
    }
    apiVoice = await aPI['titleVoice'];
    apiQuran = await aPI['titleQuran'];
    apiQuaranNet = await aPI['titleQuranNet'];

    notifyListeners();
  }
 Future<void> fetchdataTitle() async {
  try {
      var results = await Future.wait([
        http.get(apiVoice),
        http.get(apiQuran),
        http.get(apiQuaranNet),
      ]);

      final http.Response resruhaily = results[0];
      final extraVoice = json.decode(utf8.decode(resruhaily.bodyBytes))
          as Map<String, dynamic>;
      titleVoice = extraVoice;

      final http.Response resAbad = results[1];
      final extraQuran =
          json.decode(utf8.decode(resAbad.bodyBytes)) as Map<String, dynamic>;
      titleQuran = extraQuran;

      final http.Response resMidkhali = results[2];
      final extraQuranNet = json.decode(utf8.decode(resMidkhali.bodyBytes))
          as Map<String, dynamic>;
      titleQuranNet = extraQuranNet;

      notifyListeners();
    } catch (e) {
      throw e;
    }
 }

}
