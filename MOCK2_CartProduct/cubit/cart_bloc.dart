import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_event.dart';
import 'package:untitled2/MOCK2_CartProduct/cubit/cart_state.dart';
import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';


class CartBloc extends Bloc<CartEvent,CartState>{

  late List<Cart> carts = [];
  late int grandTotal = 0;
  CartBloc() : super(const CartLoadInProgress(carts: [],grandTotal: 0)){
    on<CartEvent>((event,emit){
      if(event is AddCart){
        Cart cart = event.cart;
        bool check = carts.every((element) => element.productID != cart.productID);
        if(check){
          carts.add(event.cart);
          grandTotal += cart.price;

        }else{
          for (var e in carts) {
            if (e.productID == cart.productID) {
              e.quantity++;
              e.price = e.price + cart.price;
            }
          }
          grandTotal += cart.price;
          if (kDebugMode) {
            print(carts);
          }
        }
        emit(CartAdd(carts: carts,grandTotal: grandTotal));
      }else if(event is RemoveCart){
        Cart foundCart = carts.firstWhere((cart) => cart.productID == event.indexRemove);
        carts.remove(foundCart);
        grandTotal -= foundCart.price;
        emit(CartRemove(carts: carts,grandTotal: grandTotal));
      }else if(event is ClearCart){
        carts.clear();
        grandTotal = 0;
        emit(CartClear(carts: carts, grandTotal: grandTotal));
      }
    });
  }

  List<Cart> get items => carts;

  int get grandTotals => grandTotal;
}