import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class DataProvider with ChangeNotifier {
  bool fin = false;
  Map<String, dynamic> aPI = {};
  String apiRuhaily;
  String apiAbad;
  String apiMidkhali;
  String apijelwah;
  String apiatrujah;
  String apiPlus;
  String apiRezak;
  String apiAbbas;
  String apiyatou;

  Map<String, dynamic> dataruhaily = {};
  Map<String, dynamic> dataAbad = {};
  Map<String, dynamic> dataAbbas = {};
  Map<String, dynamic> dataMidkhali = {};
  Map<String, dynamic> datajelwah = {};
  Map<String, dynamic> dataatrujah = {};
  Map<String, dynamic> dataplus = {};
  Map<String, dynamic> datarezak = {};
  Map<String, dynamic> datayatou = {};

  Future<void> fetchdataMixlrUrls() async {
    const urlf =
        'https://radio-tazgait27-default-rtdb.firebaseio.com/url/api.json';

    try {
      final http.Response url = await http.get(urlf);
      final extradataMixlrUrls = json.decode(url.body) as Map<String, dynamic>;
      aPI = extradataMixlrUrls;
    } catch (error) {
      throw error;
    }
   apiRuhaily = await aPI['ipaMixlrRuhaily'];
    apiAbad = await aPI['apiMixlrAbadLbadr'];
    apiMidkhali = await aPI['apiMidkhaliNet'];
    apijelwah = await aPI['apiJelwah'];
     apiatrujah = await aPI['apiAtrujah'];
     apiPlus = await aPI['apiplus'];
     apiRezak = await aPI['apirezak'];
     apiAbbas = await aPI['apiabbas'];
     apiyatou = await aPI['apiyatou'];
    notifyListeners();
  }

  Future<void> fetchdataTitle() async {
    try {
      var results = await Future.wait([
        http.get(apiRuhaily),
        http.get(apiAbad),
        http.get(apiMidkhali),
        http.get(apijelwah),
        http.get(apiatrujah),
        http.get(apiPlus),
        http.get(apiRezak),
        http.get(apiAbbas),
        http.get(apiyatou),
      ]);

      final http.Response resruhaily = results[0];
      final extraruhaily = json.decode(utf8.decode(resruhaily.bodyBytes))
          as Map<String, dynamic>;
      dataruhaily = extraruhaily;

      final http.Response resAbad = results[1];
      final extraAbad =
          json.decode(utf8.decode(resAbad.bodyBytes)) as Map<String, dynamic>;
      dataAbad = extraAbad;

      final http.Response resMidkhali = results[2];
      final extraMidkhali = json.decode(utf8.decode(resMidkhali.bodyBytes))
          as Map<String, dynamic>;
      dataMidkhali = extraMidkhali;

      final http.Response resjelwah = results[3];
      final extrajelwah =
          json.decode(utf8.decode(resjelwah.bodyBytes)) as Map<String, dynamic>;
      datajelwah = extrajelwah;

      final http.Response resatrujah = results[4];
      final extraatrujah = json.decode(utf8.decode(resatrujah.bodyBytes))
          as Map<String, dynamic>;
      dataatrujah = extraatrujah;

      final http.Response resplus = results[5];
      final extraplus =
          json.decode(utf8.decode(resplus.bodyBytes)) as Map<String, dynamic>;
      dataplus = extraplus;

      final http.Response resrezak = results[6];
      final extrarezak =
          json.decode(utf8.decode(resrezak.bodyBytes)) as Map<String, dynamic>;
      datarezak = extrarezak;

      final http.Response resAbbas = results[7];
      final extraAbbas =
          json.decode(utf8.decode(resAbbas.bodyBytes)) as Map<String, dynamic>;
      dataAbbas = extraAbbas;

      final http.Response resyatou = results[8];
      final extrayatou =
          json.decode(utf8.decode(resyatou.bodyBytes)) as Map<String, dynamic>;
      datayatou = extrayatou;

      notifyListeners();
    } catch (error) {
      datayatou = {"is_live": false};
      notifyListeners();
    }
  }
}
