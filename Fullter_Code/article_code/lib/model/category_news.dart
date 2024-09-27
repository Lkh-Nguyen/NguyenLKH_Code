class CategoryNewsModel{
  late String id;
  late String nameCategoryNews;

  CategoryNewsModel({required this.id,required this.nameCategoryNews});

  factory CategoryNewsModel.fromJson(Map<String,dynamic> json) =>
      CategoryNewsModel(id: json["source"]["id"] ?? "", nameCategoryNews: json["source"]["name"] ?? "");
}