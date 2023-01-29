import 'package:tmdb/utils/imports.dart';

class ApiString {
  static String logInUrl = dotenv.env['API_URL']!;
  static String imageUrl = dotenv.env['IMAGE_URL']!;
  static String apiKey = dotenv.env['API_KEY']!;
  static String aToken = dotenv.env['API_TOKEN']!;
  static String trendingListUrl =
      'https://api.themoviedb.org/3/trending/all/day';
  static String topRatedListUrl =
      'https://api.themoviedb.org/3/movie/top_rated';
  static String searchListUrl = 'https://api.themoviedb.org/3/search/multi';
}
