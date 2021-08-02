import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/layout/layoutscreen/cubit/cubit.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/layout/layoutscreen/layoutscreen.dart';
import 'package:foodapp/models/productmodel/productmodel.dart';
import 'package:foodapp/modules/cartscreen/cartscreen.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class DetailsScreen extends StatelessWidget {
  final ProductModel productModel ;
  DetailsScreen({this.productModel}) ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodLayoutCubit,FoodLayoutStates>(
     listener: (context,state){
        if (state is AddToCartSuccessState)
          {
            Fluttertoast.showToast
              (msg: 'Added to cart successfully' ,fontSize: 15 ,textColor: Colors.white ,backgroundColor: Colors.green) ;
            Navigatetoandremove(context, LayoutScreen()) ;
          }
     },
      builder: (context,state){
       var cubit = FoodLayoutCubit.get(context) ;
       return Scaffold(
         backgroundColor: Colors.grey[900],
         appBar: AppBar(
           iconTheme: IconThemeData(
               color: Colors.white
           ),
           leading: IconButton(icon:Icon(IconBroken.Arrow___Left_2),onPressed: (){
             Navigator.pop(context) ;
           },),
         ),
         body: Column(
           children: [
             Expanded(
               child: Container(
                 width: double.infinity,
                 color: Colors.grey[900],
                 child: Image(
                   image: NetworkImage(productModel.productImage),
                   width: double.infinity,
                   height: double.infinity,
                   fit: BoxFit.fill,

                 ),
               ),
             ),
             SizedBox(
               height: 10.0,
             ) ,
             Expanded(
               child: Container(
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.grey[800],
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(15),
                       topRight: Radius.circular(15),
                     )
                 ),
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text(productModel.productName , style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),) ,
                       SizedBox(height: 10.0,) ,
                       Row(
                         children: [
                           Expanded(
                             child: Row(
                               children: [
                                 CircleAvatar(
                                     backgroundColor: Colors.blueGrey,
                                     child: IconButton(icon: Icon(Icons.add , color: Colors.white,size: 15,), onPressed: (){
                                       cubit.increasenumber() ;
                                     })) ,
                                 SizedBox(width: 20.0,) ,
                                 Text('${cubit.number}',style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),) ,
                                 SizedBox(width: 20.0,) ,
                                 CircleAvatar(
                                     backgroundColor: Colors.blueGrey,
                                     child: IconButton(icon: Icon(Icons.remove , color: Colors.white,size: 15,), onPressed: (){
                                       cubit.decreasenumber() ;
                                     })) ,
                               ],
                             ),
                           ) ,
                           Text('\$ ${cubit.number==1?productModel.price:cubit.number*double.parse(productModel.price).round()}' , style: TextStyle(color: Colors.white , fontSize: 18 , fontWeight: FontWeight.bold),) ,
                         ],
                       ) ,
                       SizedBox(height: 10.0,) ,
                       Text('Description' ,style: TextStyle(color: Colors.white ,fontSize: 20.0 ,fontWeight: FontWeight.bold),)  ,
                       SizedBox(height: 5,) ,
                       Expanded(
                           child:Text(productModel.discription ,style: Theme.of(context).textTheme.caption.copyWith(color:Colors.white), )
                       ) ,
                       SizedBox(height: 10.0,) ,
                       Container(
                         height: 40.0,
                         width: double.infinity,
                         decoration: BoxDecoration(
                           color: Colors.grey[900],
                           borderRadius: BorderRadius.circular(
                               20.0
                           ) ,
                         ),
                         child: MaterialButton(
                             onPressed:(){
                               cubit.addToCart(name: productModel.productName, quantity: cubit.number.toString(), price: (double.parse(productModel.price)*cubit.number).toString(), image: productModel.productImage , id: productModel.productId) ;
                             } ,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Icon(IconBroken.Buy , color: Colors.white,),
                                 SizedBox(width: 5.0,) ,
                                 Text('Add To Cart' ,style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),)
                               ],
                             )
                         ),
                       )
                     ],
                   ),
                 ),
               ),
             )
           ],
         ),
       );
      },
    );
  }
}
