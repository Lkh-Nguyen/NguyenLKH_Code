import 'package:descover/screen/detail_screen.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int indexType;
  @override
  void initState() {
    super.initState();
    indexType = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Descover",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Data.typeView.length,
                    itemBuilder: (context, index) {
                      if (index == indexType) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                child: Text(
                                  Data.typeView.elementAt(index),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  // Bấm vào nút hiện tại không làm gì
                                },
                              ),
                              Container(
                                height: 6, // Height of the dot
                                width: 6, // Width of the dot
                                decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ]);
                      } else {
                        return Column(
                          children: [
                            TextButton(
                              child: Text(
                                Data.typeView.elementAt(index),
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Color.fromRGBO(195, 195, 195, 0.7),
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(
                              height: 5, // Height of the dot
                              width: 5, // Width of the dot
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: Data.views.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(index: index)));
                          },
                          child: SizedBox(
                            width: 280,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: ClipRRect(
                                      // Bo tròn ảnh theo viền của container
                                      borderRadius: BorderRadius.circular(40),
                                      child: Image.asset(
                                        "${Data.views.elementAt(index).url}",
                                        fit: BoxFit
                                            .cover, // Ảnh vừa khít toàn bộ container
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(243, 243, 243, 0.5),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.save,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      bottom: 60,
                                      left: 50,
                                      right: 50,
                                      child: Text(
                                        "${Data.views.elementAt(index).name}",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                  Positioned(
                                      bottom: 37,
                                      left: 50,
                                      right: 50,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          Text(
                                            Data.views.elementAt(index).country,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 16,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(243, 243, 243, 1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Popular Categories",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        buildCategory(Colors.pinkAccent,
                            "assets/images/beatch.png", "beach"),
                        buildCategory(Colors.lightBlueAccent,
                            "assets/images/camping.png", "camping"),
                        buildCategory(
                            Colors.deepPurple, "assets/images/car.png", "car"),
                        buildCategory(Colors.orangeAccent,
                            "assets/images/food.png", "food"),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategory(Color color, String imgUrl, String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.cover,
                    width: 60,
                  ),
                )),
            SizedBox(
              height: 5,
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.grid_view_rounded,
          color: Colors.grey,
          size: 35,
        ),
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search, color: Colors.grey, size: 35),
        ),
      ],
    );
  }
}
