class LicensePlate{
  late int? licensePlate_ID;
  late String? name;
  late int? Province_ID;

  LicensePlate({this.licensePlate_ID, this.name,this.Province_ID});

  Map<String,dynamic> toMap(){
    return{
      'name' : name,
      'Province_ID' : Province_ID,
    };
  }
}