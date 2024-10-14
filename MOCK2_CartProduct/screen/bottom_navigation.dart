import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/Cubit_User/screen/users_page.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/screen/detail_cart.dart';
import 'package:untitled2/MOCK2_CartProduct/screen/home_cart.dart';
import 'package:untitled2/MOCK2_CartProduct/screen/my_cart.dart';

class BTNavi extends StatefulWidget {
  const BTNavi({super.key});

  @override
  State<BTNavi> createState() => _BTNaviState();
}

class _BTNaviState extends State<BTNavi> with TickerProviderStateMixin {
  late TabController _tabController;
  String _appBarTitle = 'Home Page';
  String _appBarText = 'All available products in our store';

  int? idDetailProduct = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_setAppBarTitle);
  }

  void _setAppBarTitle() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _appBarTitle = 'Products';
          _appBarText = 'All available products in our store';
          break;
        case 1:
          _appBarTitle = 'Cart';
          _appBarText = 'All available products in our store';
          break;
        case 2:
          _appBarTitle = 'User Information';
          _appBarText = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(238, 238, 238, 1),
        title: Center(
            child: (_appBarText != '')
                ? Column(
                    children: [
                      Text(
                        _appBarTitle,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _appBarText,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        _appBarTitle,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(238, 238, 238, 1),
              width: 3.0,
            ),
          ),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 60, right: 60, top: 5, bottom: 5),
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black,
            indicator: const BoxDecoration(
              color: Colors.transparent,
            ),
            tabs: const [
              Tab(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, size: 25),
                    Text('Home'),
                  ],
                ),
              ),
              Tab(
                icon: Column(
                  children: [
                    Icon(Icons.shopping_cart, size: 25),
                    Text("Cart"),
                  ],
                ),
              ),
              Tab(
                icon: Column(
                  children: [Icon(Icons.person, size: 25), Text("Account")],
                ),
              )
            ],
          ),
        ),
      ),
      body: BlocProvider(
        create: (_) => CartBloc(),
        child: TabBarView(
          controller: _tabController,
          children: [
            idDetailProduct == -1
                ? HomeCart(
                    onProductSelected: _onProductSelected,
                    navigateToMyCart: navigateToMyCart)
                : DetailCart(
                    id: idDetailProduct!,
                    onProductSelected: _onProductSelected,
                    navigateToMyCart: navigateToMyCart),
            MyCart(navigateToHome: navigateToHome),
            const UsersScreen(),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    setState(() {
      _tabController.index = 0;
    });
  }

  void navigateToMyCart() {
    setState(() {
      _tabController.index = 1;
    });
  }

  void _onProductSelected(int id) {
    setState(() {
      idDetailProduct = id;
      _tabController.index = 0;
    });
  }
}
