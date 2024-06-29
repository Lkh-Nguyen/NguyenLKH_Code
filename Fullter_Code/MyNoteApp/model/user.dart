class User{
  late int? id;
  late String? email;
  late String? password;
  late String? gender;

  User({this.id, this.email, this.password, this.gender});

  Map<String,dynamic> toMapUser(){
    return {
      'id' : id,
      'email' : email,
      'password' : password,
      'gender' : gender,
    };
  }
}