import 'category_news.dart';

class News {
  late String author;
  late String title;
  late String description;
  late String url;
  late String urlToImage;
  late String publishedAt;
  late String content;
  late CategoryNewsModel categoryNews;

  News(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content,
      required this.categoryNews});

  factory News.fromJson(Map<String, dynamic> json) => News(
      author: json['author'] ?? "",
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      url: json['url'] ?? "",
      urlToImage: json['urlToImage'] ?? "",
      publishedAt: json['publishedAt'] ?? "",
      content: json['content'] ?? "",
      categoryNews: CategoryNewsModel(
          id: json['source']['id'] ?? "",
          nameCategoryNews: json['source']['name'] ?? ""),
  );
}
