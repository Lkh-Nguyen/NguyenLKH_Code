import 'package:flutter/material.dart';
import 'package:nikeshoe/data/shoe_data.dart';

import '../model/shoe.dart';

class Detail_Home extends StatefulWidget {
  const Detail_Home({super.key, required this.id});
  final String id;
  @override
  State<Detail_Home> createState() => _Detail_HomeState();
}



class _Detail_HomeState extends State<Detail_Home> {

  late int index;
  late int size;
  late Shoe shoe;
  @override
  void initState() {
    super.initState();
    index = int.parse(widget.id);
    size = ShoeData.shoes.elementAt(index).sizes.elementAt(0);
    shoe = ShoeData.shoes.elementAt(index);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: ClipRRect(
              // Bo tròn ảnh theo viền của container
              child: Image.asset(
                "assets/images/${ShoeData.shoes.elementAt(index).urlImage}",
                fit: BoxFit.cover, // Ảnh vừa khít toàn bộ container
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context,true);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                  icon: (!ShoeData.shoes.elementAt(index).favor)
                      ? const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                          size: 20,
                        )
                      : const Icon(Icons.favorite_border),
                  color: Colors.pink,
                  onPressed: () {
                    setState(() {
                      ShoeData.shoes.elementAt(index).favor =
                          !ShoeData.shoes.elementAt(index).favor;
                    });
                  }),
            ),
          ),
          Positioned(
            top: 550,
            left: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ShoeData.shoes.elementAt(index).type,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Size",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 60,
                  width: 300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: shoe.sizes.length,
                      itemBuilder: (context, index) {
                        if (size == shoe.sizes.elementAt(index)) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${shoe.sizes.elementAt(index)}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  size = shoe.sizes.elementAt(index);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("${shoe.sizes.elementAt(index)}",
                                      style: TextStyle(fontSize: 20,color: Colors.white)),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: 390,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text("Buy Now",style: TextStyle(fontSize: 20),),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
