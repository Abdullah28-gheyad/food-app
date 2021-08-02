import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/layout/layoutscreen/cubit/cubit.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/layout/layoutscreen/layoutscreen.dart';
import 'package:foodapp/models/shopmodel/shopmodel.dart';
import 'package:foodapp/modules/orderscreen/orederscreen.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {

  var scaffold_key = GlobalKey<ScaffoldState>() ;
  var form_key = GlobalKey<FormState>() ;
  var addressController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodLayoutCubit,FoodLayoutStates>(
      listener: (context,state){
        if (state is RemoveShopCartALLSuccessState)
          {
            Fluttertoast.showToast(
                msg: 'Added To Orders Successfully Check Your Orders ' ,
              fontSize: 18 ,
              backgroundColor: Colors.green ,
              textColor: Colors.white ,

            ) ;
          }
      },
      builder: (context,state){
        var cubit = FoodLayoutCubit.get(context) ;
        return Scaffold(
        key: scaffold_key,
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            title: Row(
              children: [
                Text('ShopCart' , style: TextStyle(color: Colors.white , fontSize: 20),) ,
                SizedBox(width: 10.0,) ,
                Icon(IconBroken.Buy , color: Colors.white,size: 30,),
              ],
            ),
            leading: IconButton(
              icon: Icon(IconBroken.Arrow___Left_2),color: Colors.white,onPressed: (){Navigatetoandremove(context, LayoutScreen()) ; },

            ),
          ),
          body: ConditionalBuilder(
            condition: cubit.shopCarts.length>0,
            builder: (context)=>SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>buildCartItem(cubit.shopCarts[index],context),
                      separatorBuilder: (context,index)=>Column(

                        children: [
                          SizedBox(height: 10,) ,
                          Container(
                            height: 4,
                            color: Colors.grey[300],
                            width: double.infinity,
                          ),
                          SizedBox(height: 10,) ,

                        ],
                      ),
                      itemCount: cubit.shopCarts.length
                  ) ,
                  SizedBox(height: 20,) ,

                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0),
                    child: Container(
                      color: Colors.grey[800],
                      height: 40.0,
                      width: double.infinity,
                      child: Card(
                        color: Colors.grey[800],
                        elevation: 5.0,
                        child: Row(
                          children: [
                            Expanded(child: Text('\$ ${cubit.summitionOrder.round()}' ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20 , ),textAlign: TextAlign.center,)) ,
                            Expanded(
                              child: InkWell(
                                  onTap: (){
                                        scaffold_key.currentState.showBottomSheet((context) => 
                                        Container(
                                          color: Colors.grey[900],
                                          child: Form(
                                              key: form_key,
                                              child: Padding(
                                            padding: const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                    defaultEditText
                                                      (
                                                        borderColor: Colors.grey[300],
                                                        iconColor: Colors.white,
                                                        hintColor: Colors.white,
                                                        textColor: Colors.white,
                                                        controller: addressController,
                                                        hintText: 'address',
                                                        prefixIcon: IconBroken.Location,
                                                        inputType: TextInputType.text,
                                                        validate: (String value)
                                                        {
                                                          if (value.isEmpty)
                                                            return'Please enter your address' ;
                                                          return null ;
                                                        }
                                                    ) ,

                                                  SizedBox(height: 20.0,) ,
                                                  Row(
                                                    children: [
                                                      Expanded(child: Text('Subtotal' , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),textAlign: TextAlign.center, )),
                                                      Expanded(child: Text('\$'+' '+cubit.summitionOrder.round().toString(), style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)) ,
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0,) ,
                                                  Row(
                                                    children: [
                                                      Expanded(child: Text('tax & Fees' , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold), textAlign: TextAlign.center,)),
                                                      Expanded(child: Text('\$5.00 ' , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)) ,
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0,) ,
                                                  Row(
                                                    children: [
                                                      Expanded(child: Text('Delivery' , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),textAlign: TextAlign.center, )),
                                                      Expanded(child: Text('Free' , style: TextStyle(color: Colors.white , fontSize: 15 , fontWeight: FontWeight.bold),textAlign: TextAlign.center,)) ,
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0,) ,
                                                 Container(
                                                   width: double.infinity,
                                                   height: 40,
                                                   decoration: BoxDecoration(
                                                     color: Colors.red,
                                                      borderRadius: BorderRadius.circular(15) ,
                                                   ),
                                                   child:MaterialButton(
                                                     child: Row(
                                                       mainAxisAlignment: MainAxisAlignment.center,
                                                       children: [
                                                         Text('Submit Order' , style: TextStyle(color: Colors.white ,fontSize: 18 ,fontWeight: FontWeight.bold),) ,
                                                         SizedBox(width: 5.0,) ,
                                                         Text('\$  ${cubit.summitionOrder.round()+5.round()}' , style: TextStyle(color: Colors.white ,fontSize: 18 ,fontWeight: FontWeight.bold),) ,

                                                       ],
                                                     ),
                                                     onPressed: (){
                                                       if (form_key.currentState.validate())
                                                         {
                                                           DateTime now = DateTime.now();
                                                           String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
                                                              cubit.submitOrder(amount:(cubit.summitionOrder.round()+5.round()).toString() ,
                                                                  currentTime: formattedDate,
                                                              userAddress: addressController.text) ;
                                                         }
                                                     },
                                                   ),
                                                 )

                                                ],
                                              ),
                                          )),
                                        ));
                                  },
                                  child: Text('OrderNow' ,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20),)),
                            ) ,
                          ],
                        ),
                      ),
                    ),
                  ) ,
                  SizedBox(
                    height: 20.0,
                  ) ,

                ],
              ),
            ),
            fallback: (context)=>Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(IconBroken.Buy , color: Colors.white,size: 100,)
                ,
                SizedBox(height: 50,) ,

                Text('Empty Cart' , style: TextStyle(color: Colors.white , fontSize: 30 , fontWeight: FontWeight.bold),),
              ],
            )),
          ),
        ) ;
      },
    );
  }
  Widget buildCartItem(ShopCartModel model,context)=> Stack(
    alignment: AlignmentDirectional.topEnd,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20) ,
            color: Colors.grey[900],
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              Expanded(
                child: Image(image: NetworkImage(model.productImage),
                  fit: BoxFit.fill,height: 120),
              ) ,
              SizedBox(width: 20,) ,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(model.productName,style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 20) , maxLines: 1 , overflow: TextOverflow.ellipsis,)) ,
                    SizedBox(height: 20.0,) ,
                    Text('\$ ${double.parse(model.productPrice).round()}' , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),) ,
                    SizedBox(
                      height: 20,
                    ) ,


                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
            backgroundColor: Colors.grey,
            child: IconButton(icon: Icon(Icons.close), onPressed: (){
              FoodLayoutCubit.get(context).removeShopCart(product_id:model.productId ) ;
            } , color: Colors.white,)),
      )
    ],
  ) ;
}
