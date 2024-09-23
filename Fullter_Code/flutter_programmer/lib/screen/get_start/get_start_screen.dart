import 'package:flutter/material.dart';
import 'package:flutter_programmer/screen/home/home_screen.dart';

class GetStart_Screen extends StatelessWidget {
  const GetStart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                      color: Colors.white,
                    )),
                Positioned(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(102, 76, 238, 1),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(70),
                        )),
                    child: Center(
                      child: Image.asset(
                          "assets/images/books.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      child: Container(
                        color: const Color.fromRGBO(102, 76, 238, 1),
                      )),
                  Positioned(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              "Learning is Everything",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Learning with Pleasure with Dear",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Programmer, Wherever you are",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 40,),
                            ElevatedButton(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color.fromRGBO(102, 76, 238, 1),
                                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: const Text(
                                    "Get Start",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

