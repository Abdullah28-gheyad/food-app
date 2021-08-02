import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/usermodel/usermodel.dart';
import 'package:foodapp/modules/signup/cubit/states.dart';
import 'package:foodapp/shared/CONSTANTS.dart';

class SignUpCubit extends Cubit <SignUpStates>
{
  SignUpCubit():super(SignUpInitialState()) ;
  static SignUpCubit get(context)=>BlocProvider.of(context) ;
  void signUp(
  {
  @required String email ,
  @required String password ,
  @required String name ,
  @required String phone ,
}
      )
  {
    emit(SignUpLoadingState()) ;
   FirebaseAuth.instance
    .createUserWithEmailAndPassword(
       email: email,
       password: password
   ).then((value){
     userCreate(name: name ,phone: phone,password: password,email: email,uid: value.user.uid) ;
     getUserData(userId: value.user.uid) ;
   })
    .catchError((error){
      print (error.toString()) ;
      emit(SignUpErrorState()) ;
   }) ;
  }
  UserModel userModel2 ;
  void userCreate(
  {
  @required String name,
  @required String email,
  @required String password,
  @required String phone ,
  @required String uid,
}
      )
  {
    emit(SignUpCreateUserLoadingState()) ;
    uId= uid ;
    userModel2 = UserModel(uId: uid ,email: email,password: password,phone: phone,name: name) ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .set(userModel2.toMap())
    .then((value) {

      emit(SignUpCreateUserSuccessState()) ;
    })
    .catchError((error){

      emit(SignUpCreateUserErrorState()) ;
    }) ;
  }

  void getUserData({
    @required String userId
  })
  {
    emit(GetUserDataLoadingState()) ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((value){
      userModel = UserModel.FromJson(value.data()) ;
      emit(GetUserDataSuccessState()) ;
    })
        .catchError((error){
      print (error.toString()) ;
      emit(GetUserDataErrorState()) ;
    }) ;
  }

}