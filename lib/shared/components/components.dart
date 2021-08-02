import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget defaultButton(
{
  Color colorButton = Colors.blue,
  Color colorText = Colors.white,
  Color borderColor ,
  double width = double.infinity ,
  @required String text ,
  @required Function function ,

}
    )=>
    Container(
  height: 40.0,
  width: width,
  decoration: BoxDecoration(
    color: colorButton,
    border: Border.all(
      color: borderColor??colorButton
    ) ,
    borderRadius: BorderRadius.circular(
      20.0
    ) ,
  ),
  child: MaterialButton(
    onPressed:function ,
    child: Text(text , style: TextStyle(color: colorText , fontSize: 20),),
  ),
) ;

Widget defaultEditText (
    {
      @required var controller ,
     Color hintColor = Colors.black ,
      @required String hintText ,
      Color borderColor = Colors.black,
      Color iconColor = Colors.black,
      Color textColor = Colors.black,
      @required IconData prefixIcon ,
      @required var inputType ,
      @required Function validate ,
      bool issecure = false ,

    }
    )=>TextFormField(
      style:  TextStyle(
        color: textColor
      ),
      controller: controller,
      validator: validate,
     keyboardType: inputType,
    obscureText: issecure,
    decoration: InputDecoration(
      hintStyle: TextStyle(
        color:hintColor
      ) ,
      hintText: hintText ,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: borderColor
        ) ,
      ) ,
      prefixIcon: Icon(prefixIcon,color: iconColor,),
    ),
);

void Navigateto(context , widget){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget,),);
}
void Navigatetoandremove(context , widget) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget,),
        (Route<dynamic> route) => false,
  );
}
