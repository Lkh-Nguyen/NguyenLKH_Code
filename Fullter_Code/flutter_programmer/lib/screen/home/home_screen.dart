import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_programmer/screen/detail/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        controller: _tabController,
        children: const [
          DetailHomeScreen(),
          DetailHomeScreen(),
          DetailHomeScreen(),
          DetailHomeScreen(),
        ],
      ),
      bottomNavigationBar: TabBar(
          labelColor: Colors.deepPurple,
          unselectedLabelColor: Colors.grey,
          indicator: const BoxDecoration(color: Colors.transparent),
          controller: _tabController,
          tabs: const [
            Tab(
              child: Column(
                children: [
                  Icon(Icons.home),
                  Text("Home"),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(Icons.add_card_sharp),
                  Text("Courses"),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(Icons.heart_broken),
                  Text("WishList"),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  Icon(Icons.manage_accounts_outlined),
                  Text("Account"),
                ],
              ),
            ),
          ]),
    );
  }
}

class DetailHomeScreen extends StatelessWidget {
  const DetailHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(102, 76, 238, 1),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        const Positioned(
                          top: 15,
                          left: 15,
                          child: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        const Positioned(
                          top: 15,
                          right: 15,
                          child: Icon(
                            Icons.notification_important,
                            color: Colors.white,
                          ),
                        ),
                        const Positioned(
                          top: 60,
                          left: 15,
                          child: Text(
                            'Hi, Programmer',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Positioned(
                          top: 120, // Increased top value
                          left: 15,
                          right: 15, // Added right to make it full-width
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Background color for visibility
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const TextField(
                              decoration: InputDecoration(
                                prefixIcon:
                                    Icon(Icons.search, color: Colors.grey),
                                hintText: "Search here ...",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(
                                    15), // Padding inside the TextField
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16.0),
                childAspectRatio: 8.0 / 9.0,
                children: [
                  _buildGridItem(Icons.home, "Category",Colors.yellow),
                  _buildGridItem(Icons.book, "Classes",Colors.green),
                  _buildGridItem(Icons.school, "Free Course",Colors.blue),
                  _buildGridItem(Icons.store, "BookStore",Colors.red),
                  _buildGridItem(Icons.live_tv, "Live Course",Colors.purple),
                  _buildGridItem(Icons.leaderboard, "LeaderBoard",Colors.green),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Courses",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25
                        ),
                      ),
                      GestureDetector(
                          onTap: (){},
                          child: const Text("See All",
                            style: TextStyle(
                              fontSize: 23,
                              color: Color.fromRGBO(102, 76, 238, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: <Widget>[
                          _buildCard('Flutter', "assets/images/Python.png", '55 Videos',context),
                          _buildCard('React Native', "assets/images/React Native.png", '55 Videos',context),
                          _buildCard('C#', "assets/images/C#.png", '55 Videos',context),
                          _buildCard('Flutter', "assets/images/Flutter.png", '55 Videos',context),
                          _buildCard('Book', "assets/images/books.png", '55 Videos',context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String label,Color color) {
    return GestureDetector(
      onTap: (){},
      child: Card(
        color: Colors.transparent,  // Thiết lập màu nền trong suốt
        elevation: 0,
        child: InkWell(
          onTap: () {
            // Thêm hành động khi nhấp vào đây
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Icon(icon, size: 30,color: Colors.white,),
                  )
              ),
              const SizedBox(height: 10),
              Text(label,style: const TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCard(String title, String urlImg, String subtitle,BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailScreen()) );
      },
      child: Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
                urlImg,
              fit: BoxFit.cover,
              width: 140,
            ),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.black)),
            Text(subtitle),
          ],
        ),
      ),
    );
  }
}

