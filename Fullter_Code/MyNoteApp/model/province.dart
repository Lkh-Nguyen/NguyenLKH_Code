class Pronvince{
  late int? Province_ID;
  late String? name;

  Pronvince({this.Province_ID, this.name});

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
    };
  }
}