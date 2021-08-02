import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/layout/layoutscreen/layoutscreen.dart';
import 'package:foodapp/modules/loginscreen/cubit/cubit.dart';
import 'package:foodapp/modules/loginscreen/cubit/states.dart';
import 'package:foodapp/modules/signup/signupscreen.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController() ;
  var passwordController = TextEditingController() ;
  var formKey = GlobalKey<FormState>() ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child : BlocConsumer<LoginCubit,LoginState>(
        listener: (context,state){
          if (state is GetUserDataSuccessState)
            {
              Fluttertoast.showToast(msg: 'Login Success'
                  ,
                  backgroundColor: Colors.green ,
                  textColor: Colors.white
              );
              Navigatetoandremove(context, LayoutScreen()) ;
            }
          if (state is LoginErrorState)
          {
            Fluttertoast.showToast(msg: 'Email or password in incorrect try again '
                ,
                backgroundColor: Colors.red ,
                textColor: Colors.white
            )  ;

          }
        },
        builder: (context,state){
          var cubit = LoginCubit.get(context) ;
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
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Center(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Log In' , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold ,fontSize: 50),) ,
                          SizedBox(height: 30,) ,
                          defaultEditText(
                              textColor: Colors.white,
                              controller: emailController,
                              validate: (String value)
                              {
                                if (value.isEmpty)
                                  return'email cannot be empty';
                                return null ;
                              },
                              prefixIcon: IconBroken.User ,
                              hintText: 'Email' ,
                              borderColor: Colors.grey,
                              hintColor: Colors.white,
                              iconColor: Colors.white ,
                              inputType: TextInputType.emailAddress
                          ),
                          SizedBox(height: 20.0,) ,
                          defaultEditText(
                              textColor: Colors.white,
                              controller: passwordController,
                              validate: (String value)
                              {
                                if (value.isEmpty)
                                  return'password cannot be empty';
                                return null ;
                              },
                              inputType: TextInputType.visiblePassword,
                              issecure: true,
                              prefixIcon: IconBroken.Lock ,
                              hintText: 'Password' ,
                              borderColor: Colors.grey,
                              hintColor: Colors.white,
                              iconColor: Colors.white
                          ),
                          SizedBox(height: 20.0,) ,
                          ConditionalBuilder(
                            condition: state is !LoginLoadingState,
                            builder: (context)=> Center(
                              child: defaultButton(
                                  text: 'Login',
                                  width: 300,
                                  colorButton: Colors.red,
                                  function: (){
                                    if (formKey.currentState.validate())
                                    {
                                      cubit.loginUser(email: emailController.text, password: passwordController.text) ;
                                    }
                                  }),
                            ),
                            fallback: (context)=>Center(child: CircularProgressIndicator()),
                          ) ,
                          SizedBox(height: 20.0,) ,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('New user ?' ,style: TextStyle(color: Colors.white),),
                              TextButton(onPressed: (){
                                Navigateto(context, SignUpScreen()) ;
                              }, child: Text('register now',style: TextStyle(color: Colors.red),))
                            ],
                          )
                        ],
                      ),
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
