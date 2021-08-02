import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/layout/layoutscreen/layoutscreen.dart';
import 'package:foodapp/modules/signup/cubit/cubit.dart';
import 'package:foodapp/modules/signup/cubit/states.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class SignUpScreen extends StatelessWidget {
  var emailController = TextEditingController() ;
  var nameController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var phoneController = TextEditingController() ;
  var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SignUpCubit(),
      child : BlocConsumer<SignUpCubit,SignUpStates>(
        listener: (context,state){
          if (state is GetUserDataSuccessState)
            {
              Fluttertoast.showToast(msg: 'SignUp Success'
                  ,
                  backgroundColor: Colors.green ,
                  textColor: Colors.white
              )  ;
              Navigatetoandremove(context, LayoutScreen()) ;
            }
          if (state is SignUpCreateUserErrorState)
          {
            Fluttertoast.showToast(msg: 'SignUp Error please change the mail '
                ,
                backgroundColor: Colors.red ,
                textColor: Colors.white
            )  ;

          }
        },
        builder: (context,state){
          var cubit = SignUpCubit.get(context) ;
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(icon:Icon(IconBroken.Arrow___Left_2,color: Colors.white),onPressed: (){
                Navigator.pop(context) ;
              },),
              foregroundColor: Colors.black,
              backgroundColor: Colors.black,
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.black
              ),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign Up' , style: TextStyle(color: Colors.white , fontSize: 40.0 , fontWeight: FontWeight.bold),) ,
                        SizedBox(height: 30.0,) ,
                        defaultEditText
                          (
                          textColor: Colors.white,
                          controller: nameController,
                          hintText: 'Name',
                          prefixIcon: IconBroken.User
                          , inputType: TextInputType.text ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return'name cannot be empty';
                            return null ;
                          },
                          iconColor: Colors.white ,
                          hintColor: Colors.white ,
                          borderColor: Colors.grey ,
                        ) ,
                        SizedBox(height: 20.0,) ,
                        defaultEditText
                          (
                          textColor: Colors.white,
                          controller: emailController,
                          hintText: 'Email',
                          prefixIcon: Icons.email
                          , inputType: TextInputType.emailAddress ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return'email cannot be empty';
                            return null ;
                          },
                          iconColor: Colors.white ,
                          hintColor: Colors.white ,
                          borderColor: Colors.grey ,
                        ) ,
                        SizedBox(height: 20.0,) ,
                        defaultEditText
                          (
                          textColor: Colors.white,
                          controller: passwordController,
                          hintText: 'password',
                          prefixIcon: IconBroken.Lock
                          , inputType: TextInputType.visiblePassword ,
                          issecure: true,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return'passowrd cannot be empty';
                            return null ;
                          },
                          iconColor: Colors.white ,
                          hintColor: Colors.white ,
                          borderColor: Colors.grey ,
                        ) ,SizedBox(height: 20.0,) ,
                        defaultEditText
                          (
                          textColor: Colors.white,
                          controller: phoneController,
                          hintText: 'Phone',
                          prefixIcon: IconBroken.Call
                          , inputType: TextInputType.number ,
                          validate: (String value)
                          {
                            if (value.isEmpty)
                              return'phone cannot be empty';
                            return null ;
                          },
                          iconColor: Colors.white ,
                          hintColor: Colors.white ,
                          borderColor: Colors.grey ,
                        ) ,
                        SizedBox(height: 20.0,) ,
                        Row(
                          children: [
                            Expanded(
                              child: defaultButton(
                                text: 'Cancel',
                                function: (){
                                  Navigator.pop(context) ;
                                }
                                ,colorButton: Colors.grey ,
                                colorText: Colors.black ,

                              ),
                            ) ,
                            SizedBox(width: 10.0,) ,
                            ConditionalBuilder(
                              condition: state is !SignUpLoadingState,
                              builder: (context)=>Expanded(
                                child: defaultButton(
                                  function: (){
                                    if (formKey.currentState.validate())
                                    {
                                      cubit.signUp(email: emailController.text, password: passwordController.text, name: nameController.text, phone: phoneController.text) ;
                                    }
                                  },
                                  text: 'Register',
                                  colorButton: Colors.red ,
                                  colorText: Colors.white ,
                                ),
                              ),
                              fallback: (context)=>Center(child: CircularProgressIndicator()),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
