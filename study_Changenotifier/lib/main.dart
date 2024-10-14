
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/category_app/Provider/add_to_cart_provider.dart';
import 'package:study_changenotifier/category_app/Provider/favorite_provider.dart';

import 'category_app/screens/nav_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      // for add to cart
      ChangeNotifierProvider(create: (_)=>CartProvider()),
      // for favorite
      ChangeNotifierProvider(create: (_)=>FavoriteProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.mulishTextTheme(),
      ),
      home: const BottomNavBar(),
    ),
  );
}
