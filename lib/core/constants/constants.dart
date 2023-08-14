import '../enums/app_enums.dart';
import '../extensions/app_extensions.dart';

class AppGlobalConstants {
  static const String moviesAPIBaseURL = 'https://api.themoviedb.org/3/';
  static const String moviesAPIKey = 'cb72c6bf17b65c674fe0c9a74baca693';
  static const String language = 'en-US';

  // general Queries
  static const String queryLanguage = "language";
  static const String queryApiKey = 'api_key';
  static const String queryPage = "page";
  static const String querySearch = "query";

  //  Api route name
  static const String routeNameApiSearch = 'search/';
  static const String routeNameApiMovie = "movie";

// endPoints
  static const String endPointTopRatedMovies = routeNameApiMovie + "/top_rated";
  static const String endPointNowPlayingMovies =
      routeNameApiMovie + "/now_playing";
  static const String endPointSearchMovies =
      routeNameApiSearch + routeNameApiMovie;

  static String imgUrl(
    String path, {
    ImgSize size = ImgSize.medium,
  }) =>
      "https://image.tmdb.org/t/p/${size.imgSize}$path";

  static const String notFoundDataDefaultMsg = "Not Found Data";
}
