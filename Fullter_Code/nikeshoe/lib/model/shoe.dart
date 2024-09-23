class Shoe {
  late String id;
  late String type;
  late int price;
  late bool favor;
  late String urlImage;
  late List<int> sizes;
  Shoe(
      {required this.id,
      required this.type,
      required this.price,
      required this.urlImage,
      required this.favor,
      required this.sizes
      });
}
