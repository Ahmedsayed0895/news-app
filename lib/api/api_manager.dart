import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/model/news_response.dart';
import 'package:newsapp/model/source_response.dart';

class ApiManager {
  static Future<SourceResponse> getSource() async {
    var url = Uri.https("newsapi.org", "v2/top-headlines/sources",
        {"apiKey": "9cc7cd1d7d4e417bb701b8897eb75e65"});
    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);
    var sourceResponse = SourceResponse.fromJson(json);
    return sourceResponse;
  }

  static Future<NewsResponse> getNews(String sourceId) async {
    var url = Uri.https(
      "newsapi.org",
      "v2/everything",
      {"apiKey": "9cc7cd1d7d4e417bb701b8897eb75e65", "sources": sourceId},
    );

    http.Response response = await http.get(url);
    var json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);
    return newsResponse;
  }
}
