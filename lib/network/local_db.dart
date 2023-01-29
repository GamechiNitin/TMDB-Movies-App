import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/utils/imports.dart';

class LocalDatabase {
  // Add to Favorite
  Future<bool> addToFavorite(List<TopRatedModel> data) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool val = await sharedPreferences.setString('favorite', jsonEncode(data));
    log("Favorite Add $val");

    return val;
  }

  Future<List<TopRatedModel>> getFavorite() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? data = sharedPreferences.getString('favorite');
    log("Favorite ${data.toString()}");
    List<TopRatedModel> rawList = <TopRatedModel>[];
    if (data != null) {
      try {
        List<dynamic> parsedJson = jsonDecode(data);
        rawList = parsedJson.map((i) => TopRatedModel.fromJson(i)).toList();
      } catch (e) {
        log(e.toString());
      }
    }
    return rawList;
  }
}
