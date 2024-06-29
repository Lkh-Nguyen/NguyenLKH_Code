class Specialty{
  late int? specialty_ID;
  late String? name;
  late int? Province_ID;

  Specialty({this.specialty_ID, this.name,this.Province_ID});

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'Province_ID' : Province_ID,
    };
  }
}