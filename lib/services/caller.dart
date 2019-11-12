import 'dart:convert';

import 'package:newswebapp/constants/FzNews.dart';
import 'package:newswebapp/services/responses.dart';
import 'package:http/http.dart' as http;

class ServiceCaller {
  // final Dio _dio = Dio();

  Future<NewsResponse> fetchNews() async {
    NewsResponse news;
    try {
      String url = FzNews.newsURL;
      // var result = await _dio.get(url);
      var result = await http.get(url);
      news = NewsResponse.fromJson(jsonDecode(result.body));
      return news;
    } catch (error) {
      String er = FzNews().getErrorMessage(error);
      throw er;
    }
  }
}
