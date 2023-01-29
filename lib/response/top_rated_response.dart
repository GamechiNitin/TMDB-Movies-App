import 'package:tmdb/model/top_rated_model.dart';

class TopRatedResponse {
  int? page;
  List<TopRatedModel>? results;
  int? totalPages;
  int? totalResults;

  TopRatedResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  TopRatedResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <TopRatedModel>[];
      json['results'].forEach((v) {
        results!.add(TopRatedModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
