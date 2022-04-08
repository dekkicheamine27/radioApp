import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class MixlrTitles with ChangeNotifier {
  Map<String, dynamic> titles = {};

  Future<void> fetchdata() async {
    const urlf =
        'https://radio-tazgait27-default-rtdb.firebaseio.com/url/-MSrsSbMVTa_yoVPAPqp.json';

    try {
      final http.Response title = await http.get(urlf);
      final extradataMixlrTitles = json.decode(title.body) as Map<String, dynamic>;
      titles = extradataMixlrTitles;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}