import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodapp/modules/loginscreen/loginscreen.dart';
import 'package:foodapp/modules/signup/signupscreen.dart';
import 'package:foodapp/shared/components/components.dart';

class WelcomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        systemOverlayStyle: SystemUiOverlayStyle(systemNavigationBarDividerColor: Colors.white,systemNavigationBarColor: Colors.white,statusBarColor: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(child: Container(
            child: Image(
              image: AssetImage('assets/images/food.jpg'),
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          )) ,
          SizedBox(height: 50.0,) ,

          Expanded(child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Text('Welcome To Tastee' , style: TextStyle(color: Colors.green , fontSize: 30 , fontWeight: FontWeight.bold),) ,
                  SizedBox(
                    height: 20.0,
                  ) ,
                  Text('order food from our resturant and ') ,
                  Text('make reservation in real-time') ,
                  SizedBox(
                    height: 30.0,
                  ) ,

                  defaultButton(
                      text: 'Login',
                      function: (){
                        Navigateto(context, LoginScreen()) ;
                      } ,
                      colorButton: Colors.green ,
                    width: 300 ,
                  ),
                  SizedBox(height: 20.0,),
                  defaultButton(
                    text: 'SignUp',
                    function: (){
                      Navigateto(context, SignUpScreen()) ;
                    } ,
                    colorButton: Colors.white ,
                    colorText: Colors.green,
                    borderColor: Colors.green,
                    width: 300 ,
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
