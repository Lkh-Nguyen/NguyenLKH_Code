import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/api/http_service.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_event.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_state.dart';
import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';

class MyCart extends StatelessWidget {
  final Function() navigateToHome;
  const MyCart({super.key, required this.navigateToHome});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SingleChildScrollView(
        child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
          var carts = state.carts;
          return Column(
            children: [
              DataTable(
                border: const TableBorder(
                    bottom: BorderSide(
                        width: 3, color: Color.fromRGBO(238, 238, 238, 1))),
                headingRowColor: MaterialStateProperty.all(
                    const Color.fromRGBO(238, 238, 238, 1)),
                // Màu nền của header
                columnSpacing: (carts.isEmpty) ? 57.0 : 16.0,
                columns: const [
                  DataColumn(
                    label: SizedBox(
                      child: Text(
                        'Product',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Qty',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Unit Price',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  DataColumn(
                    label: Expanded(
                      child: Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
                rows: carts.map((item) {
                  return DataRow(cells: [
                    DataCell(
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // Căn chỉnh các phần tử bắt đầu từ bên trái
                          children: [
                            GestureDetector(
                              onTap: () {
                                showDeleteCartDialog(context, item);
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                item.productName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    DataCell(SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: Text(
                        item.quantity.toString(),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )),
                    DataCell(SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        '\$${item.unitPrice}',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )),
                    DataCell(SizedBox(
                      width: MediaQuery.of(context).size.width * 0.2,
                      child: Text(
                        '\$${item.price}',
                        style: const TextStyle(fontWeight: FontWeight.w400),
                      ),
                    )),
                  ]);
                }).toList(),
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                  width: 3,
                  color: Color.fromRGBO(238, 238, 238, 1),
                ))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (state.grandTotal != 0)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              'Grand Total: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              '\$${state.grandTotal}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your cart is currently empty !!!',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20),
                            ),
                          ],
                        ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90.0, top: 30, right: 90),
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(228, 52, 47, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      if(state.grandTotal != 0){
                        showClearCartDialog(context);
                      }else{
                        showUnsuccessfullySnackBar(context, "Clear your cart unsuccessfully !");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.cancel_rounded, size: 20),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Clear Cart'),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90.0, top: 30, right: 90),
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(56, 193, 114, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      if (state.grandTotal != 0) {
                        HttpService.createOrder(state.grandTotal, state.carts);
                        BlocProvider.of<CartBloc>(context)
                            .add(const ClearCart());
                        showSuccessFullySnackBar(
                            context, "Check out your cart successfully");
                      } else {
                        showUnsuccessfullySnackBar(
                            context, "Check out your cart unsuccessfully");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart, size: 20),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Check out'),
                        ],
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90.0, top: 30, right: 90),
                child: ElevatedButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(56, 193, 114, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    onPressed: () {
                      navigateToHome();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_circle_left,
                            size: 20,
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text('Continue Shopping'),
                        ],
                      ),
                    )),
              ),
            ],
          );
        }),
      ),
    );
  }

  void showDeleteCartDialog(BuildContext context, Cart cart) {
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
                "Delete to Shopping Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: const Text(
            'Would you like to delete this item to your cart?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                BlocProvider.of<CartBloc>(context)
                    .add(RemoveCart(cart.productID));
                Navigator.pop(contextShowDialog);
                showDeleteSnackBar(context);
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
                  Text("Delete"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showDeleteSnackBar(BuildContext context) {
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
                'Delete products successfully!!!',
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

  void showClearCartDialog(BuildContext context) {
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
                "Clear to Shopping Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          content: const Text(
            'Would you like to clear all item to your cart?',
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                BlocProvider.of<CartBloc>(context).add(const ClearCart());
                Navigator.pop(contextShowDialog);
                showDeleteSnackBar(context);
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
                  Text("Delete"),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void showSuccessFullySnackBar(BuildContext context, String? mess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mess ?? "",
                style: const TextStyle(
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

  void showUnsuccessfullySnackBar(BuildContext context, String? mess) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                mess ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.red,
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
