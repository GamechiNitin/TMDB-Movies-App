import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:tmdb/utils/imports.dart';

class ProductRepository {
  Future<TrendingResponse?> getCategories() async {
    Map<String, String> requestParams = {'api_key': ApiString.apiKey};

    var uri = Uri.parse(ApiString.trendingListUrl);
    uri = uri.replace(queryParameters: requestParams);

    final response = await http.get(uri);

    log(":::::: ${response.statusCode} ${response.request} \n ${response.body}");

    try {
      if (response.statusCode == 200) {
        TrendingResponse trendingResponse =
            TrendingResponse.fromJson(jsonDecode(response.body));
        return trendingResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<TopRatedResponse?> getTopRatedMovie() async {
    Map<String, String> requestParams = {'api_key': ApiString.apiKey};

    var uri = Uri.parse(ApiString.topRatedListUrl);
    uri = uri.replace(queryParameters: requestParams);

    final response = await http.get(uri);

    log(":::::: ${response.statusCode} ${response.request} \n ${response.body}");

    try {
      if (response.statusCode == 200) {
        TopRatedResponse topRatedResponse =
            TopRatedResponse.fromJson(jsonDecode(response.body));
        return topRatedResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<TopRatedResponse?> getSearchMovie(String search) async {
    Map<String, String> requestParams = {
      'api_key': ApiString.apiKey,
      'query': search
    };

    var uri = Uri.parse(ApiString.searchListUrl);
    uri = uri.replace(queryParameters: requestParams);

    final response = await http.get(uri);

    log(":::::: ${response.statusCode} ${response.request} \n ${response.body}");

    try {
      if (response.statusCode == 200) {
        TopRatedResponse topRatedResponse =
            TopRatedResponse.fromJson(jsonDecode(response.body));
        return topRatedResponse;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
