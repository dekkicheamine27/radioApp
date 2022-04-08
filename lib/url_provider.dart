import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class UrlProvider with ChangeNotifier {
  Map<String, dynamic> urls = {};

  Future<void> fetchdata() async {
    const urlf =
        'https://radio-tazgait27-default-rtdb.firebaseio.com/url/urlIstaqim.json';

    try {
      final http.Response url = await http.get(urlf);
      final extradataIstaqimUrls = json.decode(url.body) as Map<String, dynamic>;
      urls = extradataIstaqimUrls;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
