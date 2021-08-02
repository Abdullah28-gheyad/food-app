import 'dart:convert';

class UserModel
{
  String name ;
  String email ;
  String password ;
  String phone ;
  String uId ;
  UserModel({this.email,this.name,this.uId,this.password,this.phone}) ;
  UserModel.FromJson(Map<String,dynamic>json)
  {
  name = json['name'] ;
  email = json['email'] ;
  password = json['password'] ;
  phone = json['phone'] ;
  uId = json['uId'] ;
  }

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'uId':uId,
    };
  }
}