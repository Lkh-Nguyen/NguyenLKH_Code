import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/api/http_service.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_event.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_state.dart';
import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';
import '../model/product.dart';

class HomeCart extends StatefulWidget {
  final Function(int) onProductSelected;
  final Function() navigateToMyCart;
  const   HomeCart({Key? key, required this.onProductSelected, required this.navigateToMyCart}) : super(key: key);

  @override
  State<HomeCart> createState() => _HomeCartState();
}

class _HomeCartState extends State<HomeCart> {
  late List<Product> products = [];
  bool isLoading = true;
  bool isLoadingMore = false;
  int page = 1;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getProducts();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        if (!isLoadingMore) {
          loadMoreProducts();
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getProducts() async {
    setState(() {
      isLoading = true;
    });
    try {
      List<Product> data = (await HttpService.getAllProducts(page)).cast<Product>();
      setState(() {
        products.addAll(data);
        page += 1;
      });
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> loadMoreProducts() async {
    setState(() {
      isLoadingMore = true;
    });
    try {
      List<Product> data = (await HttpService.getAllProducts(page)).cast<Product>();
      if (data.isNotEmpty) {
        setState(() {
          products.addAll(data);
          page += 1;
        });
      }
    } catch (e) {
      // Handle error
    } finally {
      setState(() {
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
      controller: scrollController,
      itemCount: products.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == products.length) {
          return loadingIndicator();
        }
        if (index == products.length) {
          return const Center(child: CircularProgressIndicator());
        }
        Product product = products[index];
        return showProduct(product);
      },
    );
  }

  Widget showProduct(Product product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(width: 2, color: Colors.grey),
        ),
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Image.network(product.image),
                const SizedBox(height: 16.0),
                Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  '\$${product.price} USD',
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${product.quantity} units in stock',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(66, 139, 202, 1),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              widget.onProductSelected(product.id);
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.info),
                                  SizedBox(width: 5),
                                  Text(
                                    'Details',
                                    style: TextStyle(fontSize: 20),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                      Cart cart = Cart(
                        productID: product.id,
                        productName: product.name,
                        quantity: 1,
                        unitPrice: product.price,
                        price: product.price,
                      );
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: ElevatedButton(
                              style: TextButton.styleFrom(
                                backgroundColor: const Color.fromRGBO(240, 173, 78, 1),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: () {
                                showAddCartDialog(context, cart);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.shopping_cart),
                                    SizedBox(width: 5),
                                    Text(
                                      'Order Now',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showAddSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Add products successfully!!!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showAddCartDialog(BuildContext context, Cart cart) {
    showDialog(
      context: context,
      builder: (BuildContext contextShowDialog) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 10,
          title: const Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.orange, size: 28),
              SizedBox(width: 10),
              Text(
                "Add to Shopping Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: const Text(
            'Would you like to add this item to your cart?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(contextShowDialog);
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.cancel, color: Colors.white),
                  SizedBox(width: 5),
                  Text('Cancel'),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                BlocProvider.of<CartBloc>(context).add(AddCart(cart));
                Navigator.pop(contextShowDialog);
                showAddSnackBar(context);
                widget.navigateToMyCart();
              },
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Row(
                children: [
                  Icon(Icons.add_shopping_cart, color: Colors.white),
                  SizedBox(width: 5),
                  Text("Add"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }



  Widget loadingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : const SizedBox
            .shrink(), // Hiển thị một SizedBox khi không loading
      ),
    );
  }

}
