import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:newswebapp/constants/FzNews.dart';
// import 'package:dio/dio.dart';
import 'package:newswebapp/services/responses.dart';
import 'package:http/http.dart' as http;

void main() {
  // final Dio _dio = Dio();
  test(
    "Json Fetching => ",
    () async {
      final url = FzNews.newsURL;
      // var result = await _dio.get(url);
      var result = await http.get(url);
      if (result.statusCode == 200) {
        final NewsResponse news =
            NewsResponse.fromJson(jsonDecode(result.body));
        expect(news.articles, isNotEmpty);
      }
    },
  );
}
