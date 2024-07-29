import 'package:untitled2/MOCK2_CartProduct/model/cart.dart';

abstract class CartEvent{
  const CartEvent();
}

class AddCart extends CartEvent{
  final Cart cart;
  const AddCart(this.cart);
}

class RemoveCart extends CartEvent{
  final int indexRemove;
  const RemoveCart(this.indexRemove);
}

class ClearCart extends CartEvent{
  const ClearCart();
}