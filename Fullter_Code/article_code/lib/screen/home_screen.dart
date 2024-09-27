import 'package:article_code/api/http_service.dart';
import 'package:article_code/model/news.dart';
import 'package:article_code/model/category_news.dart';
import 'package:article_code/screen/category_news.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'news_detail.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<News> newsList = [];
  List<CategoryNewsModel> categoryNewsList = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
    _fetchCategoryNews();
  }

  Future<void> _fetchNews() async {
    try {
      List<News> fetchedNews = await HttpService.fetchNews();
      setState(() {
        newsList = fetchedNews;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching news: $error');
      }
    }
  }

  Future<void> _fetchCategoryNews() async {
    try {
      List<CategoryNewsModel> fetchedCategoryNews =
      await HttpService.fetchCategoryNews();
      Set<String> seenNames = {};
      setState(() {
        categoryNewsList = fetchedCategoryNews
            .where((category) => category.nameCategoryNews.isNotEmpty) // Loại bỏ những phần tử có name rỗng
            .where((category) => seenNames.add(category.nameCategoryNews)) // Chỉ giữ lại những phần tử với tên chưa tồn tại trong Set
            .toList();
      });
      if (kDebugMode) {
        print("categoryNewsList.length: ${categoryNewsList.length}");
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching category news: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: ListView.builder(
                itemCount: categoryNewsList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => builderCategoryNews(
                    categoryNewsList.elementAt(index).nameCategoryNews, categoryNewsList.elementAt(index).id),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: newsList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => builderNew(
                    newsList.elementAt(index).url,
                    newsList.elementAt(index).title,
                    context,
                    index),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar builderAppbar() {
    return AppBar(
      title: const Center(
        child: Text(
          "Flutter News App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget builderCategoryNews(String categoryNews, String idCategoryNews) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: SizedBox(
        width: 250,
        child: ElevatedButton(
          onPressed: () {
            print(categoryNews);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CategoryNews(titleCategoryNews: categoryNews)));
          },
          style: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              )),
          child: Text(
            categoryNews,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget builderNew(String url, String title, BuildContext context,int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NewsDetail(index: index)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "https://images.axios.com/Qptg3AgpO3neLUBvKRcefpYci1U=/0x136:5376x3160/1920x1080/2024/09/25/1727226996653.jpg?w=1920",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
             Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            const Divider(
              thickness: 3,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
