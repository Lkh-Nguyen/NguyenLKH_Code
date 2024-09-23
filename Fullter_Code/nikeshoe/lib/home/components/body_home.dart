import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:nikeshoe/data/shoe_data.dart';
import 'package:nikeshoe/detail/detail_home.dart';
import 'package:nikeshoe/model/shoe.dart';

class BodyHome extends StatefulWidget {
  const BodyHome({super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {

  late List<Shoe> shoes;
  late int indexType;
  @override
  void initState() {
    super.initState();
    shoes = ShoeData.shoes;
    indexType = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: ShoeData.typeShoes.length,
              itemBuilder: (context, index) {
                if (index == indexType) {
                  return TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
                    ),
                    child: Text(
                      ShoeData.typeShoes.elementAt(index),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      // Bấm vào nút hiện tại không làm gì
                    },
                  );
                } else {
                  return TextButton(
                    child: Text(
                      ShoeData.typeShoes.elementAt(index),
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      setState(() {
                        indexType = index;
                        if (index == 0) {
                          shoes = ShoeData.shoes;
                        } else {
                          String type = ShoeData.typeShoes.elementAt(index);
                          shoes = ShoeData.shoes
                              .where((element) => element.type == type)
                              .toList();
                        }
                      });
                    },
                  );
                }
              },
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: shoes.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                final result =  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detail_Home(id : shoes.elementAt(index).id),
                    ),
                );
                if(result != null && result == true){
                  setState(() {
                    shoes = ShoeData.shoes;
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 200,
                    height: 230,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20), // Bo tròn ảnh theo viền của container
                            child: Image.asset(
                              "assets/images/${shoes.elementAt(index).urlImage}",
                              fit: BoxFit.cover, // Ảnh vừa khít toàn bộ container
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Brand Shoe",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                shoes.elementAt(index).type,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          left: 20,
                          child: Text(
                            '${shoes.elementAt(index).price}\$',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 15,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: IconButton(
                              icon: (!shoes.elementAt(index).favor) ? Icon(
                                  Icons.favorite_border,
                                color: Colors.black,
                                size: 20,
                              ) : Icon(Icons.favorite_border), color: Colors.pink,
                              onPressed: (){
                                setState(() {
                                  shoes.elementAt(index).favor = !shoes.elementAt(index).favor;
                                });
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //.animate().fade(delay: 1000.ms).slideY(begin: -1.0, end: 0, duration: 1000.ms),
              ),
            ),
          ),
        )
      ],
    );
  }
}
