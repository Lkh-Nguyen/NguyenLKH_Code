class Cart{

  final int productID;
  final String productName;
  late int quantity;
  late int unitPrice;
  late int price;


  Cart(
      {required this.productID,required this.productName,
    required this.quantity, required this.unitPrice, required this.price});

}