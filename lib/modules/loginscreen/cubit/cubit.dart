import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/models/usermodel/usermodel.dart';
import 'package:foodapp/modules/loginscreen/cubit/states.dart';
import 'package:foodapp/shared/CONSTANTS.dart';

class LoginCubit extends Cubit<LoginState>
{
  LoginCubit():super(LoginInitialState()) ;
  static LoginCubit get(context)=>BlocProvider.of(context) ;
  void loginUser(
  {
  @required String email ,
  @required String password ,
}
      )
  {
    emit(LoginLoadingState()) ;
    FirebaseAuth.instance
    .signInWithEmailAndPassword(email: email, password: password)
    .then((value){
      uId =  value.user.uid ;
      getUserData(userId: value.user.uid) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(LoginErrorState()) ;
    }) ;
  }
  UserModel userModel2 ;
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
      userModel2 = UserModel.FromJson(value.data()) ;
      userModel = UserModel.FromJson(value.data()) ;
      emit(GetUserDataSuccessState()) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit(GetUserDataErrorState()) ;
    }) ;
  }

  void updateData(
  {
  @required String name,
  @required String phone,
  @required String password,
}
      )
  {
    userModel.name=name ;
    userModel.phone=phone ;
    userModel.password=password ;
    emit(UpdateUserLoadingState())  ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .update(userModel.toMap())
    .then((value) {
      getUserData(userId: uId);
      emit(UpdateUserSuccessState()) ;
    })
    .catchError((error){

      emit(UpdateUserErrorState()) ;
    }) ;
  }



}