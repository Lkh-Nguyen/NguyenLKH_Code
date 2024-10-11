import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_changenotifier/shop_app/screen/home/products_grid.dart';

import '../../provider/product_provider.dart';



enum FilterOptions {
  Favorites,
  All,
}

class HomeProduct extends StatefulWidget {
  const HomeProduct({super.key});

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: builderAppBar(context),
      body: ProductsGrid(),
    );
  }


  AppBar builderAppBar(BuildContext context){
    return AppBar(
      title: Text('MyShop'),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.menu),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ];
          },
          onSelected: (FilterOptions value)  {
            if(value == FilterOptions.Favorites){
              context.read<ProductProvider>().getAllProductsByFavourite();
            }else{
              context.read<ProductProvider>().getAllProducts();
            }
          },
        ),
      ],
    );
  }
}


