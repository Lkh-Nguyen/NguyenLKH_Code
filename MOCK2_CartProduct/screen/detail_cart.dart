import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_event.dart';
import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';

import '../api/http_service.dart';
import '../model/product.dart';

class DetailCart extends StatefulWidget {

  final int id;
  final Function(int) onProductSelected;
  final Function() navigateToMyCart;
  const DetailCart({super.key, required this.id, required this.onProductSelected, required this.navigateToMyCart});
  
  @override
  State<DetailCart> createState() => _DetailCartState();
}

class _DetailCartState extends State<DetailCart> {
  late Product product;
  late Cart cart;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      product = (await HttpService.getProduct(widget.id));
      cart = Cart(
        productID: product.id,
        productName: product.name,
        quantity: 1,
        unitPrice: product.price,
        price: product.price,
      );
    } catch (e) {
      // Handle the error appropriately
      if (kDebugMode) {
        print("Failed to load products: $e");
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {


    return isLoading ? const Center(child: CircularProgressIndicator(),) :
      Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.network(product.image,height: 210,)),
          const SizedBox(height: 16.0),
          const Text(
            'P20 Pro 128GB Dual SIM Twilight',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 22.0),
          Text(
            product.description,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: [
              const Text(
                'Item Code: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(240, 173, 78, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    '${product.id }',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            children: [
              const Text(
                'Manufacturer: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                product.manufacturer,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
           Row(
            children: [
              const Text(
                'Category: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                product.category,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
            Row(
            children: [
              const Text(
                'Available units in stock: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 10),
              Text(
                '${product.quantity}',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Price: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              Text(
                '${product.price} USC',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12,),
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color.fromRGBO(92, 184, 92, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                    ),  
                    onPressed: (){
                      widget.onProductSelected(-1);
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_circle_left),
                          SizedBox(width: 5,),
                          Text("Back",style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
              ),
              const SizedBox(width: 30,),
              Expanded(
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromRGBO(240, 173, 78, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),
                  onPressed: () {
                    showAddCartDialog(context,cart);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        SizedBox(width: 5,),
                        Text("Order Now",style: TextStyle(fontSize: 18),),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
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
                widget.navigateToMyCart();
                showAddSnackBar(context);
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
}
