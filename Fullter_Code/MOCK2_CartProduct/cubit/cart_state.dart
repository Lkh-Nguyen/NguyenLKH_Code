import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';

abstract class CartState{
  final List<Cart> carts;
  final int grandTotal;

  const CartState({required this.carts,required this.grandTotal});
}

class CartLoadInProgress extends CartState {
  const CartLoadInProgress({required super.carts,required super.grandTotal});
}

class CartAdd extends CartState{
  final List<Cart> carts;
  final int grandTotal;
  const CartAdd({required this.carts ,required this.grandTotal}) : super(carts:carts, grandTotal: grandTotal);

  @override
  String toString() => 'ProductAdded {todos : $carts}';
}

class CartRemove extends CartState{
  final List<Cart> carts;
  final int grandTotal;
  const CartRemove({required this.carts,required this.grandTotal}) : super(carts:carts, grandTotal: grandTotal);

  @override
  String toString() => 'ProductRemoved {todos : $carts}';
}


class CartClear extends CartState{
  final List<Cart> carts;
  final int grandTotal;
  const CartClear({required this.carts,required this.grandTotal}) : super(carts:carts, grandTotal: grandTotal);

  @override
  String toString() => 'ProductRemoved {todos : $carts}';
}