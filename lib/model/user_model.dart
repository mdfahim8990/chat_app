import 'massage_model.dart';

class UserModel{
  String uid = '';
  String name ='';
  String email ='';
  String token ='';


  UserModel({this.uid,this.name,this.email,this.token});

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      token: map['token'],
    );
  }

  Map<String,dynamic> toMap(){
    return{
      'uid':uid,
      'name':name,
      'email':email,
      'token':token,
    };
  }
}