
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/http_service.dart';
import '../model/news.dart';
import 'news_detail.dart';

class CategoryNews extends StatefulWidget {
  const CategoryNews({super.key, required this.titleCategoryNews});
  final String titleCategoryNews;

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<News> newsList = [];

  @override
  void initState() {
    super.initState();
    _fetchNews();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderAppbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: ListView.builder(
          itemCount: newsList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            print(newsList.elementAt(index).categoryNews.nameCategoryNews);
            print(widget.titleCategoryNews);
            if(newsList.elementAt(index).categoryNews.nameCategoryNews == widget.titleCategoryNews) {
              return builderNew(
                  newsList.elementAt(index).url,
                  newsList.elementAt(index).title,
                  context,
                  index);
            }
            return SizedBox(height: 0,);
          }
        ),
      ),
    );
  }


  AppBar builderAppbar(){
    return AppBar(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      title: Center(
        child: Text(
          widget.titleCategoryNews,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget builderNew(String url, String title,BuildContext context,int index){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  NewsDetail(index : index)));
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
            const SizedBox(height: 10,),
            Text(title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
              ),
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
