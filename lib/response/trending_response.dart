import 'package:tmdb/model/trending_result_model.dart';

class TrendingResponse {
  int? page;
  List<TrendingResultsModel>? results;
  int? totalPages;
  int? totalResults;

  TrendingResponse(
      {this.page, this.results, this.totalPages, this.totalResults});

  TrendingResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <TrendingResultsModel>[];
      json['results'].forEach((v) {
        results!.add(TrendingResultsModel.fromJson(v));
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
