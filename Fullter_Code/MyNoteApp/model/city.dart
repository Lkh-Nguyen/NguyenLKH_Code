class City{
  late int? city_ID;
  late String? name;
  late int? Province_ID;

  City({this.city_ID, this.name,this.Province_ID});

  Map<String,dynamic> toMap(){
    return{
      'city_ID' : city_ID,
      'name' : name,
      'Province_ID' : Province_ID,
    };
  }
}