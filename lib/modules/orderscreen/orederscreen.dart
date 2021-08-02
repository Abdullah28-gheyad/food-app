import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/layout/layoutscreen/cubit/cubit.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/layout/layoutscreen/layoutscreen.dart';
import 'package:foodapp/models/ordermodel/ordermodel.dart';
import 'package:foodapp/shared/CONSTANTS.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class OrderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodLayoutCubit,FoodLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = FoodLayoutCubit.get(context) ;
        return Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2,color: Colors.white,) ,onPressed: (){
              Navigatetoandremove(context, LayoutScreen()) ;
            },),
            title:Row(

              children: [
                Icon(IconBroken.Wallet , size: 20 , color: Colors.white,) ,
                SizedBox(width: 10,) ,
                Text('Orders' , style: TextStyle(color: Colors.white , fontSize: 20.0),) ,

              ],
            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.orderModels.length>0,
            builder: (context)=> Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated

                      (
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index){
                          return  buildOrderItem(cubit.orderModels[index]) ;
                        }
                        , separatorBuilder: (context,index)=>SizedBox(height: 10.0,),
                        itemCount: cubit.orderModels.length
                    ),
                  )

                ],
              ),
            ),
            fallback: (context)=>Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Bag , color: Colors.white,size: 100,)
                ,
                SizedBox(height: 50,) ,

                Text('You Don\'t Have Orders' , style: TextStyle(color: Colors.white , fontSize: 30 , fontWeight: FontWeight.bold),),
              ],
            )),
          ),


        );
      },
    );
  }
  Widget buildOrderItem(OrderModel orderModel)
  {

    return Card(
      color: Colors.white,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('OrderDate' , style: TextStyle(color: Colors.black , fontSize: 18 ,),textAlign: TextAlign.center,)) ,
                Expanded(child: Text(orderModel.datetime , style: TextStyle(color: Colors.black , fontSize: 18),)) ,
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ) ,
            SizedBox(
              height: 10.0,
            ) ,
            Row(
              children: [
                Expanded(child: Text('User Address' , style: TextStyle(color: Colors.black , fontSize: 18 ,),textAlign: TextAlign.center,)) ,
                Expanded(child: Text(orderModel.address , style: TextStyle(color: Colors.black , fontSize: 18))) ,
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ) ,
            SizedBox(
              height: 10.0,
            ) ,
            Row(
              children: [
                Expanded(child: Text('Purchasing price' , style: TextStyle(color: Colors.black , fontSize: 18 ,),textAlign: TextAlign.center,)) ,
                Expanded(child: Text(orderModel.amount+' \$', style: TextStyle(color: Colors.black , fontSize: 18),)) ,
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ) ,
            SizedBox(
              height: 10.0,
            ) ,
            Row(
              children: [
                Expanded(child: Text('Phone' , style: TextStyle(color: Colors.black , fontSize: 18 ,),textAlign: TextAlign.center,)) ,
                Expanded(child: Text(userModel.phone , style: TextStyle(color: Colors.black , fontSize: 18),)) ,
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ) ,

          ],
        ),
      ),
    ) ;
  }
}
