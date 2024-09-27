import 'package:article_code/model/category_news.dart';
import 'package:article_code/model/news.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpService{

  static const String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=313e712139fc486796d895c700aef894";

  static Future<List<News>> fetchNews() async {
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Trích xuất danh sách bài viết từ JSON
      final articlesJson = jsonResponse['articles'] as List;
      // Chuyển danh sách JSON thành danh sách các đối tượng Article
      return articlesJson.map((article) => News.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  static Future<List<CategoryNewsModel>> fetchCategoryNews() async{
    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      // Trích xuất danh sách bài viết từ JSON
      final articlesJson = jsonResponse['articles'] as List;
      // Chuyển danh sách JSON thành danh sách các đối tượng Article
      return articlesJson.map((article) => CategoryNewsModel.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

}