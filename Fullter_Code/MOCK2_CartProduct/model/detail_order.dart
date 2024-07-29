class DetailOrder{
  final int productID;
  late int quantity;
  late int unitPrice;


  DetailOrder(
      {required this.productID, required this.quantity, required this.unitPrice}
      );

  factory DetailOrder.fromJson(Map<String,dynamic> json){
    return DetailOrder(
      productID: json['productID'],
      quantity: json['quantity'],
      unitPrice: json['uniPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productID,
      'quantity': quantity,
      'unitPrice': unitPrice,
    };
  }

}