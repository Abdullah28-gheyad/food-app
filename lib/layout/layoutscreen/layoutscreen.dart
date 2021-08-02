import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/layout/layoutscreen/cubit/cubit.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/models/categorymodel/categorymodel.dart';
import 'package:foodapp/models/productmodel/productmodel.dart';
import 'package:foodapp/modules/cartscreen/cartscreen.dart';
import 'package:foodapp/modules/detailsscreen/detailsscreen.dart';
import 'package:foodapp/modules/editprofile/editprofile.dart';
import 'package:foodapp/modules/loginscreen/loginscreen.dart';
import 'package:foodapp/modules/orderscreen/orederscreen.dart';
import 'package:foodapp/shared/CONSTANTS.dart';
import 'package:foodapp/shared/components/components.dart';
import 'package:foodapp/styles/iconbroken.dart';

class LayoutScreen extends StatelessWidget {

  var searchController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoodLayoutCubit,FoodLayoutStates>(
      listener: (context,state){

        if (state is GetShopCartSuccessState)
          {
            Navigateto(context, CartScreen()) ;
          }
        if (state is GetOrdersSuccessState)
        {
          Navigateto(context, OrderScreen()) ;
        }
      },
      builder: (context,state){
        var cubit = FoodLayoutCubit.get(context) ; 
        return  ConditionalBuilder(
          condition: userModel!=null,
          builder: (context)=>Scaffold(
            backgroundColor: Colors.grey[900],
            drawer: Drawer(
              elevation: 0.0,
              child: SafeArea(
                child: Container(
                  color: Colors.grey[900],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                            ),
                            accountName: Text(userModel.name ,style: TextStyle(color: Colors.white),),
                            accountEmail: Text(userModel.email)
                        ) ,
                        Divider(
                          color: Colors.grey[300],
                          thickness: 2,
                          height: 2,

                        ) ,
                        SizedBox(height: 10.0,) ,
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Navigateto(context, EditScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(IconBroken.User ,color: Colors.white,) ,
                                SizedBox(width: 10.0,) ,
                                Expanded(child: Text('Profile' ,style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              cubit.getShopCart() ;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(IconBroken.Buy ,color: Colors.white,) ,
                                SizedBox(width: 10.0,) ,
                                Expanded(child: Text('Cart' ,style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              cubit.getAllOrders() ;
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(IconBroken.Bag ,color: Colors.white,) ,
                                SizedBox(width: 10.0,) ,
                                Expanded(child: Text('Order' ,style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                        ) ,
                        Divider(
                          height: 2,
                          color: Colors.grey[300],
                          thickness: 2,
                        ) ,
                        SizedBox(height: 10,) ,
                        Text('Communicate',style: TextStyle(color: Colors.white),) ,
                        SizedBox(height: 10.0,) ,
                        Expanded(
                          child: InkWell(
                            onTap: (){Navigatetoandremove(context, LoginScreen()) ;  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(IconBroken.Logout ,color: Colors.white,) ,
                                SizedBox(width: 10.0,) ,
                                Expanded(child: Text('Logout' ,style: TextStyle(color: Colors.white),))
                              ],
                            ),
                          ),
                        ) ,

                      ],
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              foregroundColor: Colors.grey[900],
              backgroundColor: Colors.grey[900],
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey[900],
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    defaultEditText(
                        controller: searchController,
                        hintText: 'Search',
                        prefixIcon: IconBroken.Search,
                        inputType: TextInputType.text,
                        validate: (String value )
                        {
                          if (value.isEmpty)
                            return 'Enter keyword';
                          return null ;
                        } ,
                        textColor: Colors.white ,
                        hintColor: Colors.white ,
                        iconColor: Colors.white ,
                        borderColor: Colors.grey

                    )
                    ,
                    SizedBox(height: 20.0,) ,
                    ConditionalBuilder(
                      builder: (context)=>Container(
                        height: 120,
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index)=>buildCategoryItem(cubit.categories[index],context),
                            separatorBuilder: (context,index)=>SizedBox(width: 5.0,),
                            itemCount: cubit.categories.length
                        ),
                      ),
                      condition: cubit.categories.length>0,
                      fallback: (context)=>Center(child: CircularProgressIndicator()),
                    ) ,
                    ConditionalBuilder(
                      condition: cubit.products.length>0&&cubit.specificProducts.length==0,
                      builder: (context)=>GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2 ,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1/1.2,
                        physics: NeverScrollableScrollPhysics(),
                        children: List.generate(cubit.products.length, (index) => buildProductItem(cubit.products[index],context)),
                      ),
                      fallback: (context)=>Container(height: 1,
                        color: Colors.grey[800],width: double.infinity,),
                    ),
                    if (cubit.specificProducts.length>0)
                      ConditionalBuilder(
                        condition: cubit.specificProducts.length>0 ,
                        builder: (context)=>GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 2 ,
                          mainAxisSpacing: 1.0,
                          crossAxisSpacing: 1.0,
                          childAspectRatio: 1/1.2,
                          physics: NeverScrollableScrollPhysics(),
                          children: List.generate(cubit.specificProducts.length, (index) => buildProductItem(cubit.specificProducts[index],context)),
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()),
                      )

                  ],

                ),
              ),
            ),

          ),
          fallback:(context)=>Center(child: CircularProgressIndicator()),
        ) ; 
      },
    );
  }
  Widget buildCategoryItem(CategoryModel categoryModel,context)=>InkWell(
    onTap: (){
      FoodLayoutCubit.get(context).getSpecificProducts(categoryname: categoryModel.name) ;
    },
    child: Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration:BoxDecoration(
              color: Colors.grey ,
              borderRadius: BorderRadius.circular(10) ,
              image: DecorationImage(
                image: NetworkImage(categoryModel.image ,) ,
                fit: BoxFit.fill ,
              )
          ) ,
        ),
        Text(categoryModel.name , style: TextStyle(color: Colors.white),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 1,)
      ],
    ),
  ) ;

  Widget buildProductItem(ProductModel productModel,context)=>
      InkWell(
        onTap: (){
          Navigateto(context, DetailsScreen(productModel: productModel,)) ;
        },
        child: Container(

          height: 350,
         color: Colors.grey[800] ,
           child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
                height: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.grey[800] ,
                  image: DecorationImage(
                    image: NetworkImage(productModel.productImage) ,
                    fit: BoxFit.fill ,
                  )
              ),

            ),
            SizedBox(height: 10,) ,
            Container(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(child: Text(productModel.productName , overflow: TextOverflow.ellipsis , maxLines: 1,style: TextStyle(color: Colors.white , fontSize: 11),)) ,
                  Text('\$ ${productModel.price}' ,  overflow: TextOverflow.ellipsis , maxLines: 1,style: TextStyle(color: Colors.white,fontSize: 10),) ,
                ],
              ),
            ) ,
            SizedBox(height: 5.0,) ,
            Row(
              children: [
                Icon(Icons.star,size: 10,color: Colors.white,),
                Icon(Icons.star,size: 10,color: Colors.white,),
                Icon(Icons.star,size: 10,color: Colors.white,),
                Icon(Icons.star,size: 10,color: Colors.white,),
                Icon(Icons.star,size: 10,color: Colors.white,),
              ],
            ) ,

          ],
        ),
    ),
  ),
      ) ;
}