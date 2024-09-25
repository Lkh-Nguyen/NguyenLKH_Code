import 'package:descover/data/data.dart';
import 'package:flutter/material.dart';

import '../model/view.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  const DetailScreen({super.key, required this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Viewer viewer;

  @override
  void initState() {
    super.initState();
    viewer = Data.views.elementAt(widget.index); // Use widget.index here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: ClipRRect(
                        // Bo tròn chỉ bottomLeft và bottomRight
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                        ),
        
                        child: Image.asset(
                          "${viewer.url}",
                          fit: BoxFit.cover, // Ảnh vừa khít toàn bộ container
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(243, 243, 243, 0.5),
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
                          "${viewer.name}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    Positioned(
                      bottom: 37,
                      left: 50,
                      right: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            viewer.country,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Transform.rotate(
                      angle: 3.14,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.asset(
                          "${viewer.url}",
                          fit: BoxFit.cover, // Ảnh vừa khít toàn bộ container
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(80),
                          )),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 30,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                  Text(
                                    '5.0',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.cloud,
                                    size: 30,
                                    color: Colors.blueAccent,
                                  ),
                                  Text(
                                    '19 C',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.timer,
                                    size: 30,
                                    color: Colors.pinkAccent,
                                  ),
                                  Text(
                                    '5 Day',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 100,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  left: 40,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          50), // Bo tròn cho hình ảnh
                                      child: Image.asset(
                                        "assets/images/aa.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 70,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          50), // Bo tròn cho hình ảnh
                                      child: Image.asset(
                                        "assets/images/ab.jpeg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 100,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          50), // Bo tròn cho hình ảnh
                                      child: Image.asset(
                                        "assets/images/as.jpeg",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 130,
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.pinkAccent.shade100,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "28+",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
        
                                Positioned(
                                  left: 200,
                                  top: 10,
                                  child: Center(
                                    child: Text(
                                      "Recommended",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 45),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Description',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Text(
                                  'The way typical refers to the Cinema the Santiago,'
                                      ' a network of pilgrimarge routes. The way typical refers to the Cinema the Santiago,'
                                ' a network of pilgrimarge routes,',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(height: 40,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("\$1350",
                                      style: TextStyle(
                                          color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    ElevatedButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.pinkAccent,
                                          foregroundColor: Colors.black,
                                        ),
                                        onPressed: (){},
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                          child: Text(
                                              "Book Now",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
