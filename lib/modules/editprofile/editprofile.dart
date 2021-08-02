import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/modules/loginscreen/cubit/cubit.dart';
import 'package:foodapp/modules/loginscreen/cubit/states.dart';
import 'package:foodapp/shared/CONSTANTS.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class EditScreen extends StatelessWidget {
var nameController = TextEditingController() ;
var phoneController = TextEditingController() ;
var passwordController = TextEditingController() ;
var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){},
        builder: (context,state){
          var cubit = LoginCubit.get(context) ;
          nameController.text = userModel.name;
          phoneController.text =  userModel.phone;
          passwordController.text =  userModel.password;
          return Scaffold(
            backgroundColor: Colors.grey[900],
            appBar:AppBar(
                title: Row(
                  children: [
                    Icon(IconBroken.User , color: Colors.white,) ,
                    SizedBox(width: 10.0,) ,
                    Text('Edit Profile' ,style: TextStyle(color: Colors.white),),
                  ],
                ),
                leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2, color: Colors.white),onPressed: (){
                  Navigator.pop(context) ;
                },)
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key:  formKey,
                    child: Column(
                      children: [
                        if (state is UpdateUserLoadingState)
                             LinearProgressIndicator()  ,
                        if (state is UpdateUserLoadingState)
                          SizedBox(height: 20.0,) ,
                        defaultEditText(
                            textColor: Colors.white,
                            hintColor: Colors.white,
                            iconColor: Colors.white,
                            borderColor: Colors.grey[300],
                            controller: nameController,
                            hintText: 'Name',
                            prefixIcon: IconBroken.User,
                            inputType: TextInputType.text,
                            validate: (String value)
                            {
                              if (value.isEmpty)
                                return ' name cannot be empty ' ;
                              return null ;
                            }

                        ) ,
                        SizedBox(height: 20.0,) ,
                        defaultEditText(
                            textColor: Colors.white,
                            hintColor: Colors.white,
                            iconColor: Colors.white,
                            borderColor: Colors.grey[300],
                            controller: phoneController,
                            hintText: 'Phone',
                            prefixIcon: IconBroken.Call,
                            inputType: TextInputType.number,
                            validate: (String value)
                            {
                              if (value.isEmpty)
                                return ' phone cannot be empty ' ;
                              return null ;
                            }

                        ) ,
                        SizedBox(height: 20.0,) ,
                        defaultEditText(
                            textColor: Colors.white,
                            hintColor: Colors.white,
                            iconColor: Colors.white,
                            borderColor: Colors.grey[300],
                            controller: passwordController,
                            hintText: 'Password',
                            prefixIcon: IconBroken.Lock,
                            inputType: TextInputType.visiblePassword,
                            issecure: true,
                            validate: (String value)
                            {
                              if (value.isEmpty)
                                return ' password cannot be empty ' ;
                              return null ;
                            },

                        ) ,
                        SizedBox(height: 15.0,) ,
                        Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: TextButton(
                              onPressed: (){
                                cubit.updateData(password: passwordController.text,phone: phoneController.text,name: nameController.text) ;
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Update' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),) ,
                                  Icon(IconBroken.Edit , size: 25,)
                                ],
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          );
        },
      ),
    );
  }
}
