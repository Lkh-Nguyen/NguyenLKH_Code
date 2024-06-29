class University{
  late int? university_id;
  late String? name;
  late int? Province_ID;

  University({this.university_id, this.name,this.Province_ID});

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'Province_ID' : Province_ID,
    };
  }
}