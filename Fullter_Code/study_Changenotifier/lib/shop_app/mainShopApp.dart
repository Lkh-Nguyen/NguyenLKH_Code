import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/shop_app/provider/product_provider.dart';
import 'package:study_changenotifier/shop_app/screen/home/home_product.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeProduct(),
      ),
    );
  }
}
