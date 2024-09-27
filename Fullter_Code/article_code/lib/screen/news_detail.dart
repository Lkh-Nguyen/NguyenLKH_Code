import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../api/http_service.dart';
import '../model/news.dart';

class NewsDetail extends StatefulWidget {
  const NewsDetail({super.key, required this.index});
  final int index;

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  List<News> newsList = [];
  bool _isLoading = true;

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
        _isLoading = false;
      });
    } catch (error) {
      if (kDebugMode) {
        print("Error fetching news: $error");
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderAppbar(context),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsList.elementAt(widget.index).title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 22,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            newsList.elementAt(widget.index).author,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 250,
                      child: ClipRRect(
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
                      newsList.elementAt(widget.index).description,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  AppBar builderAppbar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back)),
      title: const Center(
        child: Text("News Everyday"),
      ),
    );
  }
}
