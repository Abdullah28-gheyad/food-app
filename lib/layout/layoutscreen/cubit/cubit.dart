
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodapp/layout/layoutscreen/cubit/states.dart';
import 'package:foodapp/models/categorymodel/categorymodel.dart';
import 'package:foodapp/models/ordermodel/ordermodel.dart';
import 'package:foodapp/models/productmodel/productmodel.dart';
import 'package:foodapp/models/shopmodel/shopmodel.dart';
import 'package:foodapp/modules/loginscreen/cubit/cubit.dart';
import 'package:foodapp/shared/CONSTANTS.dart';

class FoodLayoutCubit extends Cubit<FoodLayoutStates>
{
  FoodLayoutCubit():super(FoodInitialState()) ;
  static FoodLayoutCubit get(context)=>BlocProvider.of(context) ;
  List<ProductModel>products=[] ;
  List<String>categoryname=[];
  List<CategoryModel>categories=[] ;
  void getProducts()
  {
    emit(FoodGetProductsLoadingState());
    FirebaseFirestore.instance
    .collection('products')
    .get()
    .then((value){
      value.docs.forEach((element) {
        if (!categoryname.contains(element.data()['categoryType']))
          {
            categoryname.add(element.data()['categoryType']) ;
            categories.add(CategoryModel.FromJson(element.data())) ;
          }
        products.add(ProductModel.FromJson(element.data())) ;
      });
      emit(FoodGetProductsSuccessState()) ;
    })
    .catchError((error)
    {
      print (error.toString()) ;
      emit(FoodGetProductsErrorState()) ;
    });
  }


  List<ProductModel> specificProducts=[] ;
  void getSpecificProducts(
  {
  @required String categoryname ,
}
      )
  {
    specificProducts=[] ;
    emit(FoodGetSpecificProductsLoadingState());
    FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((value){
      value.docs.forEach((element) {
        if (element.data()['categoryType'].contains(categoryname))
        {
          specificProducts.add(ProductModel.FromJson(element.data())) ;
        }});
      products=[];
      emit(FoodGetSpecificProductsSuccessState()) ;

    })
        .catchError((error)
    {
      print (error.toString()) ;
      emit(FoodGetSpecificProductsErrorState()) ;
    });
  }


  int number=1;
  void increasenumber()
  {
    number++ ;
    emit(ChangeNumberState()) ;
  }
  void decreasenumber()
  {
    if (number>1)
        number-- ;
    emit(ChangeNumberState()) ;
  }

  ShopCartModel cartModel ;
  void addToCart(
  {
  @required String name ,
  @required String quantity ,
  @required String price ,
  @required String image ,
  @required String id ,
}
      ) {
    emit(AddToCartLoadingState());
    cartModel = ShopCartModel(productImage: image,
        productName: name,
        productPrice: price,
        productQuantity: quantity ,
        productId: id
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('shoplogin')
        .get()
        .then((value) {
        if (value.docs.contains(id))
          {
            Fluttertoast.showToast(msg: 'You Have already added it before') ;
          }
        else
          {
            FirebaseFirestore.instance
                .collection('users')
                .doc(uId)
                .collection('shoplogin')
                .doc(id)
                .set(cartModel.toMap())
                .then((value) {
              emit(AddToCartSuccessState());
            })
                .catchError((error) {
              print(error.toString());
              emit(AddToCartErrorState());
            });
          }
    }).catchError((error){
      emit(AddToCartErrorState());
    });

  }

  double summitionOrder=0 ;
  List<ShopCartModel> shopCarts = [] ;
 void getShopCart()
 {
   shopCarts = [];
   summitionOrder=0 ;
   emit(GetShopCartLoadingState()) ;
   FirebaseFirestore.instance
   .collection('users')
   .doc(uId)
   .collection('shoplogin')
   .get()
   .then((value){
     value.docs.forEach((element) {
       summitionOrder+=double.parse(element.data()['productPrice']);
       shopCarts.add(ShopCartModel.FromJson(element.data())) ;
     }) ;
     emit(GetShopCartSuccessState()) ;
   })
   .catchError((error)
   {
     print (error.toString()) ;
     emit(GetShopCartErrorState()) ;
   }) ;
 }
  void removeShopCart(
  {
@required String product_id ,
}
)
{
emit(RemoveShopCartItemLoadingState()) ;
FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('shoplogin')
    .doc(product_id)
      .delete()
  .then((value) {
    emit(RemoveShopCartItemSuccessState()) ;
    getShopCart() ;
    })
.catchError((error){

  print (error.toString()) ;
  emit(RemoveShopCartItemErrorState()) ;
    }) ;
}

OrderModel orderModel ;
  void submitOrder(
  {
  @required String userAddress ,
  @required String  currentTime ,
  @required String amount ,
}
      )
  {
    emit (MakeOrderLoadingState()) ;
    orderModel = OrderModel(datetime: currentTime.toString() ,address: userAddress , amount:amount ) ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('orders')
    .add(orderModel.topMap())
    .then((value){
      removeAllShopCart() ;
      emit(MakeOrderSuccessState()) ;
    })
    .catchError((error){

      print (error.toString()) ;
      emit (MakeOrderErrorState()) ;
    }) ;
  }

  void removeAllShopCart()
  {
    shopCarts = [];
    emit(RemoveShopCartALLLoadingState()) ;
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
    .collection('shoplogin')
    .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
      getShopCart() ;
      emit(RemoveShopCartALLSuccessState()) ;
    }).catchError((error)
      {
        print (error.toString()) ;
        emit(RemoveShopCartALLErrorState()) ;
      }
    );
  }

  List<OrderModel> orderModels=[] ;
  void getAllOrders()
  {
    orderModels=[] ;
    emit (GetOrdersLoadingState()) ;
    FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .collection('orders')
    .orderBy('datetime')
    .get()
    .then((value){
      value.docs.forEach((element) {
        orderModels.add(OrderModel.FromJson(element.data())) ;
      }) ;
      emit (GetOrdersSuccessState()) ;
    })
    .catchError((error){
      print (error.toString()) ;
      emit (GetOrdersErrorState()) ;
    });
  }

}