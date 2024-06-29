class ScenicSpot{
  late int? scenicSpot_ID;
  late String? name;
  late int? Province_ID;

  ScenicSpot({this.scenicSpot_ID, this.name,this.Province_ID});

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'Province_ID' : Province_ID,
    };
  }
}