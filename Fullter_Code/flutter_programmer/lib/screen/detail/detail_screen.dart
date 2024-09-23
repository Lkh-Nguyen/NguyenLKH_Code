import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Flutter',
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.deepPurpleAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Center(
              child: Container(
                height: 150,
                width: 150,
                child: Image.asset(
                  'assets/images/Flutter.png', // Link logo Flutter
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 20),
            // Course Title
            Text(
              'Flutter Complete Course',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Created by Dear Programmer',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '55 Videos',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Videos",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                ),
                SizedBox(width: 20,),
                Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("Description",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),))
                ),
              ],
            ),
            SizedBox(height: 20),
            // Video List
            Expanded(
              child: ListView(
                children: [
                  buildVideoItem('Introduction to Flutter', '20 min 50 sec'),
                  buildVideoItem('Installing Flutter on Windows', '20 min 50 sec'),
                  buildVideoItem('Setup Emulator on Windows', '20 min 50 sec'),
                  buildVideoItem('Creating Our First App', '20 min 50 sec'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildVideoItem(String title, String duration) {
    return ListTile(
      leading: Container(
          decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.play_arrow, color: Colors.white),
          )
      ),
      title: Text(title),
      subtitle: Text(duration),
      onTap: () {
        // Handle video play
      },
    );
  }
}
